#!/usr/bin/env python
#-*- coding: utf-8 -*-

import web

web.config.debug = True

render = web.template.render("templates/", globals = {})
web.template.Template.globals['render'] = render
