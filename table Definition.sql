CREATE TABLE Book ( 
    bid INT PRIMARY KEY AUTO_INCREMENT, 
    book_num VARCHAR(30) NOT NULL UNIQUE,
    type VARCHAR(30),
    title VARCHAR(30) NOT NULL, 
    press VARCHAR(30), 
    year YEAR, 
    author VARCHAR(30), 
    price DECIMAL(10, 2), 
    amount INT NOT NULL, 
    stock INT NOT NULL
);

CREATE TABLE Card ( 
    cid INT PRIMARY KEY AUTO_INCREMENT, 
    card_num VARCHAR(30) NOT NULL UNIQUE,
    card_name VARCHAR(30) NOT NULL, 
    unit VARCHAR(30), 
    type char(1) NOT NULL
);

CREATE TABLE Admin (
    uid INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(30) NOT NULL UNIQUE,
    password VARCHAR(30) NOT NULL,
    real_name VARCHAR(30),
    contact_info VARCHAR(30)
);

CREATE TABLE Record (
    rid INT PRIMARY KEY AUTO_INCREMENT,
    bid INT NOT NULL,
    cid INT NOT NULL,
    borrow_date DATETIME NOT NULL,
    return_date DATETIME,
    uid INT NOT NULL,
    FOREIGN KEY (bid) REFERENCES Book(bid),
    FOREIGN KEY (cid) REFERENCES Card(cid),
    FOREIGN KEY (uid) REFERENCES Admin(uid)
);

INSERT INTO ADMIN (username, password) 
VALUES ('root','-5995064038896156292');
INSERT INTO `Book` VALUES (13,'bno1','计算机','SQL Server 2008完全学习手册','清华出版社',2001,'郭郑州',79.80,5,5),(14,'bno2','计算机','程序员的自我修养','电子工业出版社',2013,'俞甲子',65.00,5,5),(15,'bno3','教育','做新教育的行者','福建教育出版社',2002,'高云鹏',25.00,3,3),(16,'bno4','教育','做孩子眼中有本领的父母','电子工业出版社',2013,'高云鹏',23.00,5,5),(17,'bno5','英语','实用英文写作','高等教育出版社',2008,'庞继贤',33.00,3,3),(1,'bno6','TAOCP','CS','GG',1999,'Knuth',10000.00,1,1),(3,'bno7','TAOCP','CS','GG',1999,'Knuth',10000.00,1,1),(4,'cno1','SQL Server 2008','计算机','清华出版社',2001,'郭郑州',79.80,5,5);

