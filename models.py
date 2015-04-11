import web
import simplejson as json
import time
db = web.database(dbn='mysql', db='libdata', user='root', pw = '123654', charset = 'utf8', use_unicode = False)

def addAdmin(username, password, real_name, contact_info):
	if username == "" or password == "":
		return -1
	try:
		db.insert('Admin', username = username, password = hash(password), real_name = real_name, contact_info = contact_info)
	except:
		return -1
	return 0

def checkAdmin(username, password):
	q = "SELECT uid FROM Admin WHERE username = '%s' AND password = '%s'" % (username, hash(password))
	l = db.query(q)
	if l == []:
		return 0, -1;
	else:
		return 1, l[0]['uid']

def addCard(card_num, card_name, unit, ctype):
	if card_num == "" or card_name == "" or ctype == "":
		return -1;
	try:
		db.insert("Card", card_num = card_num, card_name = card_name, unit = unit, type = ctype)
		return 0
	except:
		return -1;

def removeCard(card_num):
	q = "SELECT cid FROM Card WHERE card_num = '%s'" % card_num
	l = db.query(q).list()
	if l == []:
		return -1
	try:
		cid = l[0]['cid']
		q = "SELECT rid FROM Record WHERE cid = %s AND return_date IS NULL" % (cid)
		l = db.query(q).list()
		if l != []:
			return -2
		db.delete("Record", where = "cid = '%s'" % cid)
		db.delete("Card", where = "cid = '%s'" % cid)
		return 0
	except:
		return -1;

def getCid(card_num):
	return db.query("SELECT cid FROM Card WHERE card_num = '%s'" % card_num).list()

def addBook(book_num, bookType, title, press, year, author, price, amount):
	# TODO: implement ' handling
	if book_num == "" or title == "" or amount == "":
		return -1

	q = "INSERT INTO Book (book_num, type, title, press, year, author, price, amount, stock) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')" % (book_num, bookType, title, press, year, author, price, amount, amount)
	db.query(q)

	return 0

def appendBook(book_num, stock):
	# TODO: implement ' handling
	if book_num == "" or stock == "":
		return -1

	q = "SELECT bid FROM Book WHERE book_num = '%s'" % (book_num)
	l = db.query(q).list()
	if l == []:
		return -1

	try:
		q = "UPDATE Book SET stock = stock + %s WHERE bid = %s" % (stock, l[0]['bid'])
		db.query(q)
		q = "UPDATE Book SET amount = amount + %s WHERE bid = %s" % (stock, l[0]['bid'])
		db.query(q)
	except:
		return -1

	return 0

def borrowBook(cid, book_num, uid):
	q = "SELECT stock, bid FROM Book WHERE book_num = '%s'" % book_num
	l = db.query(q).list()
	if l == []:
		return "book_num error"
	elif l[0]['stock'] == 0:
		q = "SELECT return_date FROM Record WHERE bid = '%s' ORDER BY return_date desc" % l[0]['bid']
		l = db.query(q).list()
		print str(l[0]['return_date'])
		return "stock error+" + str(l[0]['return_date'])
	else:
		q = "UPDATE Book SET stock = %s WHERE book_num = '%s'" % (l[0]['stock'] - 1, book_num)
		db.query(q)
		q = "INSERT INTO Record(bid, cid, borrow_date, return_date, uid) VALUES (%s, %s, '%s', NULL, %s)" % (l[0]['bid'], cid, time.strftime('%Y-%m-%d %H:%M:%S'), uid)
		db.query(q)
		return 0

def returnBook(cid, book_num):
	q = "SELECT bid FROM Book WHERE book_num = '%s'" % book_num
	l = db.query(q).list()
	if l == []:
		return "book_num error"
	bid = l[0]['bid']
	q = "SELECT rid FROM Record WHERE bid = %s AND cid = %s AND return_date IS NULL" % (bid, cid)
	l = db.query(q).list()
	if l == []:
		return "book_num error"
	else:
		q = "UPDATE Record SET return_date = '%s' WHERE rid = %s" % (time.strftime('%Y-%m-%d %H:%M:%S'), l[0]['rid'])
		db.query(q)
		q = "SELECT stock FROM Book WHERE bid = %s" % (bid)
		l = db.query(q)
		q = "UPDATE Book SET stock = %s WHERE book_num = '%s'" % (l[0]['stock'] + 1, book_num)
		db.query(q)
		return 0

def queryBookByUser(card_num):
	q = "SELECT B.book_num, B.type, B.title, B.press, B.year, B.author, B.price, B.stock FROM Book B JOIN Record R ON(B.bid = R.bid) WHERE cid = '%s' AND return_date IS NULL" % card_num
	booklist = db.query(q)
	return booklist

def queryBookList(bookType, title, press, year, author, price):
	main = "SELECT book_num, type, title, press, year, author, price, stock FROM Book "
	whereClause = "WHERE "
	whereClauseList = [];

	if (bookType != ''):
		whereClauseList.append("type LIKE '%s'" % ('%' + bookType + '%'))
	if (title != ''):
		whereClauseList.append("title LIKE '%s'" % ('%' + title + '%'))		
	if (press != ''):
		whereClauseList.append("press LIKE '%s'" % ('%' + press + '%'))		
	if (year[0] != '' and year[1] != ''):
		print (year[0], year[1])
		whereClauseList.append("year BETWEEN '%s' AND '%s'" % (year[0], year[1]))
	if (author != ''):
		whereClauseList.append("author LIKE '%s'" % ('%' + author + '%'))
	if (price[0] != '' and price[1] != ''):
		whereClauseList.append("price BETWEEN '%s' AND '%s'" % (price[0], price[1]))

	if (whereClauseList == []):
		whereClause += "TRUE"
	else:
		whereClause += " AND ".join(x for x in whereClauseList)

	booklist = db.query(main + whereClause).list()
	return booklist

