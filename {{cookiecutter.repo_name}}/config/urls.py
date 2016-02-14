# -*- coding: utf-8 -*-
"""{{ cookiecutter.repo_name }} URL Configuration

https://docs.djangoproject.com/en/1.8/topics/http/urls/

"""
from django.conf.urls import include, url
from django.contrib import admin
from django.views.generic import TemplateView


urlpatterns = [
    url(
        regex=r'^admin/',
        view=include(admin.site.urls)),

    url(
        regex=r'^$',
        view=TemplateView.as_view(template_name='base.html'),
        name="home"),
]
