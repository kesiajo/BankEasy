import base64
from cryptography.fernet import Fernet
from iota import Iota
from iota import ProposedTransaction
from iota import Address
from iota import Tag
from iota import TryteString
import json
import pickle


class BEKey:
	def __init__(self):
		self.key = ''
		self.account_number = ''
		self.ifsc_code = ''
		self.branch = ''
		self.account_holder = ''
		self.tangle_address = ''
		self.latest_transaction = ''
		self.load_details()
		self.api = Iota('https://nodes.devnet.iota.org:443', testnet = True)
		self.fernet_encryptor = Fernet(self.key)

	def load_details(self):
		with open('account_details.db', 'rb') as user_file:
			user_details = pickle.load(user_file)
			self.key = user_details['key']
			self.account_number = user_details['account_number']
			self.ifsc_code = user_details['ifsc_code']
			self.branch = user_details['branch']
			self.account_holder = user_details['account_holder']
			self.tangle_address = user_details['tangle_address']
			self.latest_transaction = user_details['latest_transaction']

	def update_details(self):
		with open('account_details.db', 'wb') as user_file:
			user_details = {}
			user_details['key'] = self.key 
			user_details['account_number'] = self.account_number
			user_details['ifsc_code'] = self.ifsc_code
			user_details['branch'] = self.branch
			user_details['account_holder'] = self.account_holder
			user_details['tangle_address'] = self.tangle_address
			user_details['latest_transaction'] = self.latest_transaction
			pickle.dump(user_details, user_file)

	def tangle_transaction_commit(self, account_balance):
		msg_dict = {
			"account_number": self.account_number,
			"ifsc_code": self.ifsc_code,
			"branch": self.branch,
			"account_holder": self.account_holder,
			"account_balance": account_balance
		}
		message = TryteString.from_unicode(json.dumps(msg_dict))
		tx = ProposedTransaction(
			address = Address(self.tangle_address),
			message = message,
			value = 0
		)
		result = self.api.send_transfer(transfers = [tx])
		self.latest_transaction = result['bundle'].tail_transaction.hash

	def tangle_transaction_read(self):
		bundle = self.api.get_bundles(self.latest_transaction)
		message = bundle['bundles'][0].tail_transaction.signature_message_fragment
		decoded_msg = json.loads(message.decode())
		return decoded_msg['account_balance']

	def encrypt(self, amount):
		encoded_message = amount.encode()
		return self.fernet_encryptor.encrypt(encoded_message).decode()

	def decrypt(self, account_balance):
		decrypted_message = self.fernet_encryptor.decrypt(account_balance).encode()
		return decrypted_message.decode()

	def withdraw(self, amount):
		encrypted_account_balance = self.tangle_transaction_read()
		account_balance = self.decrypt(encrypted_account_balance)
		if amount <= int(account_balance):
			account_balance -= amount
			new_account_balance = self.encrypt(account_balance)
			self.tangle_transaction_commit(new_account_balance)
			self.update_details()
			return True
		else:
			print("Not Enough Balance!")
			return False

	def vignere_encrypt(self, plaintext):
		ciphertext = []
		start = ord('a')
		for l, k in zip(plaintext, self.key):
			if l != "=":
				shift = ord(k) - start
				pos = start + (ord(l) - start + shift) % 26
				ciphertext.append(chr(pos))
			else:
				ciphertext.append("=")
		return ''.join([l for l in ciphertext])

	def vignere_decrypt(self, ciphertext):
		key_length = len(self.key)
		key_as_int = [ord(i) for i in self.key]
		ciphertext_int = [ord(i) for i in ciphertext]
		plaintext = ''
		for i in range(len(ciphertext_int)):
			value = (ciphertext_int[i] - key_as_int[i % key_length]) % 26
			plaintext += chr(value + 65)
		return plaintext

	def base_decode(self, ciphertext):
		base64_bytes = ciphertext.encode('ascii')
		message_bytes = base64.b64decode(base64_bytes)
		message = message_bytes.decode('ascii')
		return message

	def base_encode(self, plaintext):
		message_bytes = plaintext.encode('ascii')
		base64_bytes = base64.b64encode(message_bytes)
		base64_message = base64_bytes.decode('ascii')
		return base64_message

	def __str__(self):
		encrypted_account_balance = self.tangle_transaction_read()
		account_balance = self.decrypt(encrypted_account_balance)
		return '''
		Account number     \t {self.account_number}
		IFSC Code          \t {self.ifsc_code}
		Branch             \t {self.branch}
		Account holder     \t {self.account_holder}
		Latest Transaction \t {self.latest_transaction}
		Account Balance    \t {account_balance}
		'''

	# def encrypt(self, account_balance):
	# 	first_encryption = self.base_encode(account_balance)
	# 	print(first_encryption)
	# 	result = self.key_encrypt(first_encryption)
	# 	return result

	# def decrypt(self, cipher):
	# 	first_decryption = self.key_decrypt(cipher)
	# 	print(first_decryption)
	# 	result = self.base_decode(first_decryption)
	# 	return result

if __name__ == '__main__':
	be_key = BEKey()
	print('BE Key Demo')
	print(be_key)

