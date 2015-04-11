# -*- coding: utf-8 -*-
import web
from web import form
from setting import render
import Admin
import models
import simplejson as json

urls = ("/", "Admin.Login",
        "/admin", "Admin.Admin",
        "/logout", "Admin.Logout",
        "/admin/addbook", "Admin.AddBook",
        "/admin/addbooklist", "Admin.AddBookList",
        "/admin/addadmin", "Admin.AddAdmin",
        "/admin/managecard", "Admin.ManageCard",
        "/borrowbook", "BorrowBook",
        "/returnbook", "ReturnBook",
        "/querybooks", "QueryBooks",
        "/(js|css|statics)/(.*)", "Static",
        "/(.*)/", "redirect",
        )
app = web.application(urls, globals())

if web.config.get('_session') is None:
    session = web.session.Session(app, web.session.DBStore(models.db, 'sessions'), {"login": 0, "uid": -1, "cid": -1})
    web.config._session = session
else:
    session = web.config._session


def session_hook():
    web.ctx.session = session
    web.ctx.app = app

def internalerror(mess = "500 internal error"):
    return web.internalerror(mess)

app.internalerror = internalerror

app.add_processor(web.loadhook(session_hook))

class Static:
    def GET(self, media, file):
        try:
            f = open('templates/' + media + '/' + file, 'r')
            return f.read()
        except:
            return ''

class redirect:
    def GET(self, path):
        print path
        if session.login != 1 and path != 'admin':
            web.seeother('/')
        raise web.seeother('/' + path)

class BorrowBook():
    def GET(self):
        if session.login != 1:
            raise web.seeother('/#login')
        card_num = web.input()
        if card_num.get('card_num') == None or card_num.get('card_num') == "":
            return render.brbook(form.Form(form.Textbox('card_num', description = 'Card ID', class_ = 'form-control')), form.Form(form.Textbox('book_num', description = 'Book Number', class_ = 'form-control')), "borrowbook", session)
        else:
            cid = models.getCid(card_num['card_num'])
            if cid == []:
                raise app.internalerror(mess = "card_num error")
            session.cid = cid[0]['cid']
            l = map(dict, models.queryBookByUser(session.cid).list())
            return json.dumps(l, use_decimal=True)
    def POST(self):
        if session.login != 1:
            raise web.seeother('/#login')
        if session.cid == -1:
            raise app.internalerror(mess = "card_num error")
        book_num = web.input()
        l = models.borrowBook(session.cid, book_num['book_num'], session.uid)
        if l == 0:
            return "Success!"
        elif l.startswith("stock error"):
            # print l.split('+')[1]
            raise app.internalerror(mess = l.split('+')[1])
        else:
            raise app.internalerror(mess = l)


class ReturnBook():
    def GET(self):
        if session.login != 1:
            raise web.seeother('/#login')
        card_num = web.input()
        if card_num.get('card_num') == None or card_num.get('card_num') == "":
            return render.brbook(form.Form(form.Textbox('card_num', description = 'Card ID', class_ = 'form-control')), form.Form(form.Textbox('book_num', description = 'Book Number', class_ = 'form-control')), "returnbook", session)
        else:
            cid = models.getCid(card_num['card_num'])
            if cid == []:
                raise app.internalerror(mess = "card_num error")
            session.cid = cid[0]['cid']
            l = models.queryBookByUser(session.cid).list()
            l = map(dict, models.queryBookByUser(session.cid).list())
            return json.dumps(l, use_decimal=True)
    def POST(self):
        if session.login != 1:
            raise web.seeother('/#login')
        if session.cid == -1:
            raise app.internalerror(mess = "card_num error")
        book_num = web.input()
        l = models.returnBook(session.cid, book_num['book_num'])
        if l == 0:
            return "Success!"
        else:
            raise app.internalerror(mess = l)

class QueryBooks():
    def GET(self):
        query = form.Form(
            form.Textbox('type', description = 'Book type', class_ = 'form-control'),
            form.Textbox('title', description = 'Book name', class_ = 'form-control'),
            form.Textbox('press', description = 'Press', class_ = 'form-control'),
            form.Textbox('yearfrom', description = 'Year from', class_ = 'form-control'),
            form.Textbox('yearto', description = 'Year to', class_ = 'form-control'),
            form.Textbox('author', description = 'Author', class_ = 'form-control'),
            form.Textbox('pricefrom', description = 'Price from', class_ = 'form-control'),
            form.Textbox('priceto', description = 'Price to', class_ = 'form-control'),
            # form.Button('Submit', class_ = "btn btn-primary"),
            )
        return render.querybooks(query, session)
    def POST(self):
        query = web.input()
        l = models.queryBookList(query.get('type'), query.get('title'), query.get('press'), (query.get('yearfrom'), query.get('yearto')), query.get('author'), (query.get('pricefrom'), query.get('priceto')))
        if l == -1:
            raise app.internalerror("error")
        l = map(dict, l)
        return json.dumps(l, use_decimal=True)


if __name__ == "__main__":
    app.run()
