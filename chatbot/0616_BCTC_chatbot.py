import telegram
from telegram import ReplyKeyboardMarkup,InlineKeyboardMarkup, InlineKeyboardButton
from telegram.ext import Updater, CommandHandler, CallbackQueryHandler,Dispatcher, MessageHandler, Filters
import configparser

config = configparser.ConfigParser()
config.read('config.ini')
access_token = config['TELEGRAM']['ACCESS_TOKEN']


def start(bot, update):
    update.message.reply_text(
        'Hello🙋🏻, {}'.format(update.message.from_user.first_name))
    bot.send_photo(chat_id=update.message.chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/BTS%26P.png')
    update.message.reply_text('我是 ⎨ BTS&P ⎬  Better than S&P500 --你的投資理財小幫手😃！')
    update.message.reply_text('\n 💰您有聽過因子投資嗎？\n\n因子是能夠解釋和產生額外收益的資產特性，讓我們一起透過因子選股、複製出股神的投資風格吧！')
    update.message.reply_text('點擊 ➟ /style 讓我們一起開始吧！🤩')

def style(bot, update):
    reply_keyboard = [["🥇⎨市場狙擊手⎬ Bill Ackman"], ["🥈⎨對沖基金教父⎬ Stephen Mandel"], ["🏅⎨價值投資⎬ Chuck Akre"]]
    response = ReplyKeyboardMarkup(reply_keyboard, one_time_keyboard=False)
    update.message.reply_text("您好😃 喜歡哪一種投資風格呢?", reply_markup=response)
    

def reply_handler(bot, update):
    text = update.message.text
    chat_id = update.message.chat_id
    if text == "🥇⎨市場狙擊手⎬ Bill Ackman":
        bot.send_photo(chat_id=chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/bill_ackman.jpg')
        keyboard = [
        [
            InlineKeyboardButton('🔍績效', callback_data = 'Bill performance'),
            InlineKeyboardButton('🔍成份', callback_data = 'Bill composition'),
            InlineKeyboardButton('💵下單',url = 'https://www.ctbcbank.com/twrbo/zh_tw/index.html')
        ],
        [
            InlineKeyboardButton('🔔訂閱', callback_data = 'sub 00')
        ],
        [
            InlineKeyboardButton('📢 分享',switch_inline_query ='嗨~~ 🙌🏻\n\n 我發現一個簡單好用的 ⎨ AI選股機器人🤖⎬! \n\n 點選➟ @CTBC_FundBot 快來看看！！')
        ]]
        replyMarkup = telegram.InlineKeyboardMarkup(keyboard)
        bot.send_message(chat_id=update.message.chat_id,text='🥇⎨市場狙擊手⎬ Bill Ackman\n\n一位被稱為市場狙擊手，甚擁有鷹眼般選股功力的強者....\n究竟他是如何選股的？\n我們根據Bill Ackman的投資因子，建造出一個風格與他一樣的投組，想了解更多.....')
        update.message.reply_text('想要了解什麼呢？',reply_markup = replyMarkup)


    elif text == "🥈⎨對沖基金教父⎬ Stephen Mandel":
        bot.send_photo(chat_id=chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/stephen_mandel.jpg')
        keyboard = [
        [
            InlineKeyboardButton('🔍績效', callback_data = 'Mandel performance'),
            InlineKeyboardButton('🔍成份', callback_data = 'Mandel composition'),
            InlineKeyboardButton('💵下單',url = 'https://www.ctbcbank.com/twrbo/zh_tw/index.html')
        ],
        [
            InlineKeyboardButton('🔔訂閱', callback_data = 'sub 00')
        ],
        [
            InlineKeyboardButton('📢 分享',switch_inline_query ='嗨~~ 🙌🏻\n\n 我發現一個簡單好用的 ⎨ AI選股機器人🤖⎬!\n\n 點選➟ @CTBC_FundBot 快來看看！！')
        ]]
        replyMarkup = telegram.InlineKeyboardMarkup(keyboard)
        bot.send_message(chat_id=update.message.chat_id,text='🥈⎨對沖基金教父⎬ Stephen Mandel\n\n一位被稱為對沖基金教父，甚擁有鷹眼般選股功力的強者....\n究竟他是如何選股的？\n我們根據Stephen Mandel的投資因子，建造出一個風格與他一樣的投組，想了解更多.....')
        update.message.reply_text('想要了解什麼呢？',
                reply_markup = replyMarkup)
        
    elif text == "🏅⎨價值投資⎬ Chuck Akre":
        bot.send_photo(chat_id=chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/Chuck_Akre.jpeg')
        keyboard = [
        [
            InlineKeyboardButton('🔍績效', callback_data = 'Akre performance'),
            InlineKeyboardButton('🔍成份', callback_data = 'Akre composition'),
            InlineKeyboardButton('💵下單',url = 'https://www.ctbcbank.com/twrbo/zh_tw/index.html')
        ],
        [
            InlineKeyboardButton('🔔訂閱', callback_data = 'sub 00')
        ],
        [
            InlineKeyboardButton('📢 分享', switch_inline_query ='嗨~~ 🙌🏻\n\n 我發現一個簡單好用的 ⎨ AI選股機器人🤖⎬!\n\n 點選➟ @CTBC_FundBot 快來看看！！')
        ]]
        replyMarkup = telegram.InlineKeyboardMarkup(keyboard)
        bot.send_message(chat_id=update.message.chat_id,text='🏅⎨價值投資⎬ Chuck Akre\n\n一位被稱為價值投資者，甚擁有鷹眼般選股功力的強者....\n究竟他是如何選股的？\n我們根據Chuck Akre的投資因子，建造出一個風格與他一樣的投組，想了解更多.....')
        update.message.reply_text('想要了解什麼呢？',
                reply_markup = replyMarkup)

def answer_callback_data(bot, update):
    global SUBSCRIBE
    name,key = update.callback_query.data.split(' ')
    chat_id = update.callback_query.message.chat_id
    if name == 'Bill':
        if key == 'performance':
            bot.send_message(chat_id = chat_id,text='⬇︎ ⚜️BTS&P 高度模擬 ⎨市場狙擊手⎬ Bill Ackman 的投資組合報酬表現 \n\n\t\t\t»點選圖可放大檢視')
            bot.send_photo(chat_id = chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/LPC_return.png')
        elif key == 'composition':
            bot.send_message(chat_id = chat_id,text='⬇︎ ⚜️BTS&P 高度模擬⎨市場狙擊手⎬ Bill Ackman 的組合成分 \n\n\t\t\t»點選圖可放大檢視')
            bot.send_photo(chat_id = chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/LPC_composition.png')
    elif name == 'Mandel':
        if key == 'performance':
            bot.send_message(chat_id = chat_id,text='⬇︎ ⚜️BTS&P 高度模擬 ⎨對沖基金教父⎬ Stephen Mandel 的組合報酬表現 \n\n\t\t\t»點選圖可放大檢視')
            bot.send_photo(chat_id = chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/LPC_return.png')
        elif key == 'composition':
            bot.send_message(chat_id = chat_id,text='⬇︎ ⚜️BTS&P 高度模擬 ⎨對沖基金教父⎬ Stephen Mandel 的投資組合成分 \n\n\t\t\t»點選圖可放大檢視')
            bot.send_photo(chat_id = chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/LPC_composition.png')
            
    elif name == 'Akre':
        if key == 'performance':
            bot.send_message(chat_id = chat_id,text='⬇︎ ⚜️BTS&P 高度模擬 ⎨價值投資⎬ Chuck Akre 的組合報酬表現 \n\n\t\t\t»點選圖可放大檢視')
            bot.send_photo(chat_id = chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/LPC_return.png')
        elif key == 'composition':
            bot.send_message(chat_id = chat_id,text='⬇︎ ⚜️BTS&P 高度模擬 ⎨價值投資⎬ Chuck Akre 的組合成分 \n\n\t\t\t»點選圖可放大檢視')
            bot.send_photo(chat_id = chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/LPC_composition.png')
    elif name == 'sub':
        if SUBSCRIBE == 0:
            SUBSCRIBE = 1
            bot.send_message(chat_id = chat_id,text='謝謝您，您已成功訂閱！\n\n ⚜️BTS&P將在每季推出三位股神的模擬投資組合！\n 幫您找出⎨股神的投資風格密碼⎬🎊')
            return SUBSCRIBE
        else:
            SUBSCRIBE = 0
            bot.send_message(chat_id = chat_id,text='謝謝您，您已取消訂閱！')
            return SUBSCRIBE

def help(bot,update):
    update.message.reply_text('⚜️BTS&P將在每季，推出獲選最有潛力的投資人模擬基金！')
    update.message.reply_text('{}\n{}\n{}\n{}\n{}\n{}'.format(
        '點擊 ➟  /style  選擇您所喜愛的投資人風格',
        '點擊 ➟  🔍績效  查看AI建投組/投資人/SMP500 的報酬比較圖',
        '點擊 ➟  🔍成分  查看AI建投組 的成分股與Top10權重',
        '點擊 ➟  💵下單  等不及啦~立刻手刀下單',
        '點擊 ➟  🔔訂閱  訂閱BTS&P，BTS&P將在每季推出三位股神的模擬投資組合！',
        '點擊 ➟  📢分享  好康互相報，分享BTS&P給你的朋友',
        ))



        
SUBSCRIBE = 0
updater = Updater(access_token)
updater.dispatcher.add_handler(CommandHandler('start', start))
updater.dispatcher.add_handler(CommandHandler('style', style))
updater.dispatcher.add_handler(CommandHandler('help', help))
updater.dispatcher.add_handler(MessageHandler(Filters.text, reply_handler))
updater.dispatcher.add_handler(CallbackQueryHandler(answer_callback_data))


updater.start_polling()
updater.idle()