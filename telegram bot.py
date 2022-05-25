#!/usr/bin/python
import config
import telegram
import os
import subprocess
import sys
import shlex
import datetime
from subprocess import Popen, PIPE
from telegram.ext import CommandHandler
from imp import reload

#bot = telegram.Bot(token = config.token)
#Проверка бота
#print(bot.getMe())
from telegram.ext import Updater
updater = Updater(token=config.token)
dispatcher = updater.dispatcher


def run_command(command):
    process = subprocess.Popen(shlex.split(command), stdout=subprocess.PIPE)
    global textoutput
    textoutput = ''
    while True:
        global output
        output = process.stdout.readline()
        output = output.decode('utf8')
        if output == '' and process.poll() is not None:
            break
        if output:
            print (output.strip())
        textoutput = textoutput + '\n' + output.strip()
    rc = process.poll()
    return rc

#функция команады start
def start(update, context):
    context.bot.sendMessage(chat_id=update.message.chat_id, text="Привет, я бот, жду команды")

#функция команады help
def help(update, context):
    reload(config)
    context.bot.sendMessage(chat_id=update.message.chat_id, text='''список доступных команд:
    /id - id пользователя
    /ifconfig - сетевые настройки
    /df - информация о дисковом пространстве (df -h)
    /free - информация о памяти
    /curlsh - ip server
    /curl2sh - create bot
    ''')

#функция команады id
def myid(update, context):
    userid = update.message.from_user.id
    context.bot.sendMessage(chat_id=update.message.chat_id, text=userid)

#функция команады curlsh - ip server
def curlsh(update, context):
    reload(config)
    user = str(update.message.from_user.id)
    if user in config.admin: #если пользовательский id в списке admin то команда выполняется
        run_command("curlsh")
        context.bot.sendMessage(chat_id=update.message.chat_id, text=textoutput)

#функция команады curl2sh - create bot
def curl2sh(update, context):
    reload(config)
    user = str(update.message.from_user.id)
    if user in config.admin: #если пользовательский id в списке admin то команда выполняется
        run_command("curl2sh")
        context.bot.sendMessage(chat_id=update.message.chat_id, text=textoutput)       

#функция команады ifconfig
def ifconfig(update, context):
    reload(config)
    user = str(update.message.from_user.id)
    if user in config.admin: #если пользовательский id в списке admin то команда выполняется
        run_command("ifconfig")
        context.bot.sendMessage(chat_id=update.message.chat_id, text=textoutput)

#функция команады df
def df(update, context):
    reload(config)
    user = str(update.message.from_user.id)
    if user in config.admin: #если пользовательский id в списке admin то команда выполняется
        run_command("df -h")
        context.bot.sendMessage(chat_id=update.message.chat_id, text=textoutput)

#функция команады free
def free(update, context):
    reload(config)
    user = str(update.message.from_user.id)
    if user in config.admin: #если пользовательский id в списке admin то команда выполняется
        run_command("free -m")
        context.bot.sendMessage(chat_id=update.message.chat_id, text=textoutput)

start_handler = CommandHandler('start', start)
dispatcher.add_handler(start_handler)

ifconfig_handler = CommandHandler('ifconfig', ifconfig)
dispatcher.add_handler(ifconfig_handler)

df_handler = CommandHandler('df', df)
dispatcher.add_handler(df_handler)

free_handler = CommandHandler('free', free)
dispatcher.add_handler(free_handler)

myid_handler = CommandHandler('id', myid)
dispatcher.add_handler(myid_handler)

help_handler = CommandHandler('help', help)
dispatcher.add_handler(help_handler)

curlsh_handler = CommandHandler('curlsh', curlsh)
dispatcher.add_handler(curlsh_handler)

curl2sh_handler = CommandHandler('curl2sh', curl2sh)
dispatcher.add_handler(curl2sh_handler)


updater.start_polling()
