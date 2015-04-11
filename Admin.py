# -*- coding: utf-8 -*- 
import web
from web import form
from setting import render
import models
import simplejson as json



def logged():
    return web.ctx.session.login == 1

class Login:
    def GET(self):
        if logged():
            raise web.seeother('/admin')

        login = form.Form(
            form.Textbox('username', description = 'Username', class_ = 'form-control'),
            form.Password('password', description = 'Password', class_ = 'form-control'),
            # form.Button('Login', class_ = "btn btn-primary"),
            )
        return render.login(login,web.ctx.session)

    def POST(self):
        username, password = web.input().username, web.input().password
        web.ctx.session.login, web.ctx.session.uid = models.checkAdmin(username, password)
        if web.ctx.session.login > 0:
            return "login succeed."
        else:
            return "username or password error"
class Logout:
    def GET(self):
        web.ctx.session.login, web.ctx.session.uid = 0, -1
        raise web.seeother('/#logout')

class Admin:
    def GET(self):
        if web.ctx.session.login != 1:
            raise web.seeother('/#login')
        return render.admin(web.ctx.session)

class ManageCard:
    def GET(self):
        if web.ctx.session.login != 1:
            raise web.seeother('/#login')
        addCard = form.Form(
            form.Textbox('card_num', description = 'Card ID', class_ = 'form-control'),
            form.Textbox('card_name', description = 'Name', class_ = 'form-control'),
            form.Textbox('unit', description = 'Unit', class_ = 'form-control'),
            form.Dropdown('type', [('S', 'Student'), ('T', 'Teacher')], description = 'Identity', class_ = 'form-control'),
            form.Hidden("optype", value = "add"),
            # form.Button('Create', class_ = "btn btn-primary")
            )
        removeCard = form.Form(
            form.Textbox('card_num', description = "Card ID", class_ = 'form-control'),
            form.Hidden("optype", value = "remove"),
            # form.Button("Submit", class_ = "btn btn-primary"),
            )
        return render.managecard(addCard, removeCard, web.ctx.session)
    def POST(self):
        if web.ctx.session.login != 1:
            raise web.seeother('/#login')
        card = web.input()
        if card['optype'] == "add":
            ret = models.addCard(card['card_num'], card['card_name'], card['unit'], card['type'])
            if ret == 0:
                return "Insert succeed."
            else:
                raise web.ctx.app.internalerror("error");
        elif card['optype'] == "remove":
            ret = models.removeCard(card['card_num'])
            if ret == 0:
                return "Remove succeed."
            elif ret == -1:
                raise web.ctx.app.internalerror("card_num error");
            else:
                raise web.ctx.app.internalerror("record error");


# TODO: implement append book
class AddBook:
    def GET(self):
        if web.ctx.session.login != 1:
            raise web.seeother('/#login')
        addbook = form.Form(
            form.Textbox('book_num', description = "Book Number", class_ = 'form-control'),
            form.Textbox('type', description = 'Book type', class_ = 'form-control'),
            form.Textbox('title', description = 'Book name', class_ = 'form-control'),
            form.Textbox('press', description = 'Press', class_ = 'form-control'),
            form.Textbox('year', description = 'Year', class_ = 'form-control'),
            form.Textbox('author', description = 'Author', class_ = 'form-control'),
            form.Textbox('price', description = 'Price', class_ = 'form-control'),
            form.Textbox('amount', description = 'Amount', class_ = 'form-control'),
            form.Hidden('optype', value = 'addbook'),
            # form.Button("Submit", class_ = "btn btn-primary"),
            )
        appendbook = form.Form(
            form.Textbox('book_num', description = 'Book Number', class_ = 'form-control'),
            form.Textbox('quantity', description = 'Quantity', class_ = 'form-control'),
            form.Hidden('optype', value = 'appendbook'),
            )
        addbooklist = form.Form(
            form.File(name = "Upload"),
            # form.Button("Submit", class_ = "btn btn-primary"),
            )
        return render.addbook(addbook, appendbook, addbooklist,web.ctx.session)
    def POST(self):
        # TODO: implement exception handling
        if web.ctx.session.login != 1:
            raise web.seeother('/#login')
        data = web.input()
        if data['optype'] == 'addbook':
            ret = models.addBook(data['book_num'], data['type'], data['title'], data['press'], data['year'], data['author'], data['price'], data['amount'])
            if ret == 0:
                return "Insert succeed"
            else:
                raise web.ctx.app.internalerror("error")
        else:
            ret = models.appendBook(data['book_num'], data['quantity'])
            if ret == 0:
                return "Insert succeed"
            else:
                raise web.ctx.app.internalerror("error")

        # raise web.seeother('/admin/addbook')
#        return data

class AddBookList:
    """
    This class is used to handle batch import
    """
    def GET(self):
        if web.ctx.session.login != 1:
            raise web.seeother('/#login')

    def POST(self):
        if web.ctx.session.login != 1:
            raise web.seeother('/#login')
        data = web.input(Upload = {})
        for item in data['Upload'].file.read().splitlines():
            info = item.strip('( )').split(', ')
            # info = filter(None, re.split(u"[,，()（） 　]", item))
            models.addBook(info[0], info[1], info[2], info[3], info[4], info[5], info[6], info[7])
        return "Insert succeed"


class AddAdmin:
    def GET(self):
        if web.ctx.session.login != 1:
            raise web.seeother('/#login')
        user = form.Form(
            form.Textbox('username', description = 'Username', class_ = 'form-control'),
            form.Password('password', description = 'Password', class_ = 'form-control'),
            form.Textbox('real_name', description = 'Name', class_ = 'form-control'),
            form.Textbox('contact_info', description = 'Contact info', class_ = 'form-control'),
            # form.Button('Create', class_ = "btn btn-primary"),
            )
        return render.addadmin(user,web.ctx.session)

    def POST(self):
        # TODO: implement exception handling
        if web.ctx.session.login != 1:
            raise web.seeother('/#login')
        data = web.input()
        ret = models.addAdmin(data['username'], data['password'], data['real_name'], data['contact_info'])
        if ret == 0:
            return "Insert succeed"
        else:
            raise web.ctx.app.internalerror("error")



