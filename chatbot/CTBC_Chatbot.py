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
    reply_keyboard = [["🥇⎨市場狙擊手⎬ Bill Ackman"], ["🥈⎨對沖基金教父⎬ Stephen Mandel"], ["🏅⎨價值投資⎬ Chuck Akre"],["About BTS&P"]]
    response = ReplyKeyboardMarkup(reply_keyboard, one_time_keyboard=False)
    update.message.reply_text("您好😃 喜歡哪一種投資風格呢?", reply_markup=response)
    

def reply_handler(bot, update):
    text = update.message.text
    chat_id = update.message.chat_id
    if text == "🥇⎨市場狙擊手⎬ Bill Ackman":
        bot.send_photo(chat_id=chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/bill_ackman.jpg')
        keyboard = [
        [
            InlineKeyboardButton('🔍簡介', callback_data = 'Bill indroduction'),
            InlineKeyboardButton('🔍績效', callback_data = 'Bill performance'),
            InlineKeyboardButton('🔍持股', callback_data = 'Bill composition')
        ],
        [
            InlineKeyboardButton('💵手刀下單',url = 'https://www.ctbcbank.com/twrbo/zh_tw/index.html')
        ],
        [
            InlineKeyboardButton('🔔訂閱', callback_data = 'sub 00'),
            InlineKeyboardButton('📢 分享',switch_inline_query ='嗨~~ 🙌🏻\n\n 我發現一個簡單好用的 ⎨ AI選股機器人🤖⎬! \n\n 點選➟ @CTBC_FundBot 快來看看！！')
        ]]
        replyMarkup = telegram.InlineKeyboardMarkup(keyboard)
        bot.send_message(chat_id=update.message.chat_id,text='🥇⎨市場狙擊手⎬ Bill Ackman\n\n一位被稱為市場狙擊手，甚擁有鷹眼般選股功力的強者....\n究竟他是如何選股的？\n我們根據Bill Ackman的投資因子，建造出一個風格與他一樣的投組，想了解更多.....')
        update.message.reply_text('想要了解什麼呢？',reply_markup = replyMarkup)


    elif text == "🥈⎨對沖基金教父⎬ Stephen Mandel":
        bot.send_photo(chat_id=chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/stephen_mandel.jpg')
        keyboard = [
        [
            InlineKeyboardButton('🔍簡介', callback_data = 'Mandel indroduction'),
            InlineKeyboardButton('🔍績效', callback_data = 'Mandel performance'),
            InlineKeyboardButton('🔍持股', callback_data = 'Mandel composition')
        ],
        [
            InlineKeyboardButton('💵手刀下單',url = 'https://www.ctbcbank.com/twrbo/zh_tw/index.html')
        ],
        [
            InlineKeyboardButton('🔔訂閱', callback_data = 'sub 00'),
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
            InlineKeyboardButton('🔍簡介', callback_data = 'Akre indroduction'),
            InlineKeyboardButton('🔍績效', callback_data = 'Akre performance'),
            InlineKeyboardButton('🔍持股', callback_data = 'Akre composition')
        ],
        [
            InlineKeyboardButton('💵手刀下單',url = 'https://www.ctbcbank.com/twrbo/zh_tw/index.html')
        ],
        [
            InlineKeyboardButton('🔔訂閱', callback_data = 'sub 00'),
            InlineKeyboardButton('📢 分享', switch_inline_query ='嗨~~ 🙌🏻\n\n 我發現一個簡單好用的 ⎨ AI選股機器人🤖⎬!\n\n 點選➟ @CTBC_FundBot 快來看看！！')
        ]]
        replyMarkup = telegram.InlineKeyboardMarkup(keyboard)
        bot.send_message(chat_id=update.message.chat_id,text='🏅⎨價值投資⎬ Chuck Akre\n\n一位被稱為價值投資者，甚擁有鷹眼般選股功力的強者....\n究竟他是如何選股的？\n我們根據Chuck Akre的投資因子，建造出一個風格與他一樣的投組，想了解更多.....')
        update.message.reply_text('想要了解什麼呢？',
                reply_markup = replyMarkup)
    elif text == "About BTS&P":
        bot.send_message(chat_id=chat_id,text='我們複製知名基金經理人的投資風格來進行選股，\n讓投資人輕鬆擁有超級經理人「巴菲特」、「比爾艾克曼」等風格基金！\n各種名人投資風格也將陸續推出！\n\n我們將投資人歷年的投資組合進行產業、FAMA的五因子迴歸分析，\n更進一步，\n我們還將經濟數據指標透過機器學習來建構我們的景氣預測模型。\n\n這個景氣預測模型可以用來判斷未來景氣的好壞，\n根據景氣的好壞我們會調整投組的組成和權重，\n並且利用機器學習來找出最佳的投資組合以及權重。\n\n「在景氣好時，我們希望投組能賺得更多，\n在景氣壞時，我們希望投組能虧的比別人少。」\n讓投資人能獲得最大的利益。\n\n－－想了解更多，快訂閱追蹤我們🙌🏻')
        bot.send_photo(chat_id=chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/how.png')
    else:
        bot.send_message(chat_id = chat_id,text='點擊 ➟  /style  選擇您所喜愛的投資人風格')

def answer_callback_data(bot, update):
    global SUBSCRIBE
    name,key = update.callback_query.data.split(' ')
    chat_id = update.callback_query.message.chat_id
    if name == 'Bill':
        if key == 'indroduction':
            bot.send_message(chat_id = chat_id,text='{}\n{}\n\n{}\n{}\n\n{}'.format(
            '✢投資人名稱：Bill Ackman',
            '✢職稱：Pershing Square Capital 基金經理人',
            '✢報酬：半年報酬高達 49.4%',
            '✢基金淨額：$6.57 B',
            '✢簡介：Bill Ackman是一位著名的對沖基金經理，在疫情期間標普500指數從高點慘崩20%以上，多數投資人賠到肉痛時，避他卻靠著信貸保護合約，大賺26億美元。Ackman說:他已經進場抄底。\n-- 想模擬他的投資組合風格嗎🤩？'))


        elif key == 'performance':

            bot.send_message(chat_id = chat_id, text='想要看什麼區間的績效呢？',
            reply_markup = InlineKeyboardMarkup([[
                InlineKeyboardButton('過去1年',callback_data = 'Bill 1'),
                InlineKeyboardButton('過去3年',callback_data = 'Bill 3'),
                InlineKeyboardButton('過去10年',callback_data = 'Bill 10')
                ]]))
        elif key == 'composition':
            bot.send_message(chat_id = chat_id,text='⬇︎ ⚜️BTS&P 模擬⎨市場狙擊手⎬ Bill Ackman 的持股明細 \n\n\t\t\t»點選圖可放大檢視')
            bot.send_photo(chat_id = chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/BillAckman_Stocks.png')
        elif key == '1':
            bot.send_message(chat_id = chat_id,text='⬇︎ ⚜️BTS&P 模擬 ⎨市場狙擊手⎬ Bill Ackman 的過去1年績效走勢 \n\n\t\t\t»點選圖可放大檢視')
            bot.send_photo(chat_id = chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/BillAckman_1.png')
        elif key == '3':
            bot.send_message(chat_id = chat_id,text='⬇︎ ⚜️BTS&P 模擬 ⎨市場狙擊手⎬ Bill Ackman 的過去3年績效走勢 \n\n\t\t\t»點選圖可放大檢視')
            bot.send_photo(chat_id = chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/BillAckman_3.png')
        elif key == '10':
            bot.send_message(chat_id = chat_id,text='⬇︎ ⚜️BTS&P 模擬 ⎨市場狙擊手⎬ Bill Ackman 的過去10年績效走勢 \n\n\t\t\t»點選圖可放大檢視')
            bot.send_photo(chat_id = chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/BillAckman_10.png')


    elif name == 'Mandel':
        if key == 'indroduction':
            bot.send_message(chat_id = chat_id,text='{}\n{}\n\n{}\n{}\n\n{}'.format(
            '✢投資人名稱：Stephen Mondel',
            '✢職稱：Lone Pine Capital 基金經理人',
            '✢報酬：年化收益率高達36%',
            '✢基金淨額：$16.4 B',
            '✢簡介：他擅長基本面分析並深入預測公司的走向和未來發展，《我們向來不是什麼抄底者，只要看到好公司就值得買入》－ Stephen Mondel \n-- 想模擬他的投資組合風格嗎🤩？'))
        elif key == 'performance':
            bot.send_message(chat_id = chat_id, text='想要看什麼區間的績效呢？',
            reply_markup = InlineKeyboardMarkup([[
                InlineKeyboardButton('過去1年',callback_data = 'Mandel 1'),
                InlineKeyboardButton('過去3年',callback_data = 'Mandel 3'),
                InlineKeyboardButton('過去10年',callback_data = 'Mandel 10')
                ]]))
        elif key == 'composition':
            bot.send_message(chat_id = chat_id,text='⬇︎ ⚜️BTS&P 模擬 ⎨對沖基金教父⎬ Stephen Mandel 的持股明細 \n\n\t\t\t»點選圖可放大檢視')
            bot.send_photo(chat_id = chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/StephenMandel_Stocks.png')
        elif key == '1':
            bot.send_message(chat_id = chat_id,text='⬇︎ ⚜️BTS&P 模擬 ⎨對沖基金教父⎬ Stephen Mandel  的過去1年績效走勢 \n\n\t\t\t»點選圖可放大檢視')
            bot.send_photo(chat_id = chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/StephenMandel_1.png')
        elif key == '3':
            bot.send_message(chat_id = chat_id,text='⬇︎ ⚜️BTS&P 模擬 ⎨對沖基金教父⎬ Stephen Mandel  的過去3年績效走勢 \n\n\t\t\t»點選圖可放大檢視')
            bot.send_photo(chat_id = chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/StephenMandel_3.png')
        elif key == '10':
            bot.send_message(chat_id = chat_id,text='⬇︎ ⚜️BTS&P 模擬 ⎨對沖基金教父⎬ Stephen Mandel  的過去10年績效走勢 \n\n\t\t\t»點選圖可放大檢視')
            bot.send_photo(chat_id = chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/StephenMandel_10.png')
        



    elif name == 'Akre':
        if key == 'indroduction':
            bot.send_message(chat_id = chat_id,text='{}\n{}\n\n{}\n{}\n\n{}'.format(
            '✢投資人名稱：Chuck Akre',
            '✢職稱：Akre Capital 基金經理人',
            '✢報酬：年化收益率達13%',
            '✢基金淨額：$10.3 B',
            '✢簡介：《長期間追求持續、不中斷的複利是個聰明的投資，也正是我們的目標。許多人將我們視為“價值投資者”，其他人疑惑我們是價值還是成長型投資人。我們兩者都不是，我們是複利型投資人。》－ Chuck Akre\n-- 想模擬他的投資組合風格嗎🤩？ '))
        elif key == 'performance':
            bot.send_message(chat_id = chat_id, text='想要看什麼區間的績效呢？',
            reply_markup = InlineKeyboardMarkup([[
                InlineKeyboardButton('過去1年',callback_data = 'Akre 1'),
                InlineKeyboardButton('過去3年',callback_data = 'Akre 3'),
                InlineKeyboardButton('過去10年',callback_data = 'Akre 10')
                ]]))
        elif key == 'composition':
            bot.send_message(chat_id = chat_id,text='⬇︎ ⚜️BTS&P 模擬 ⎨價值投資⎬ Chuck Akre 的持股明細 \n\n\t\t\t»點選圖可放大檢視')
            bot.send_photo(chat_id = chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/Akre_Stocks.png')
        elif key == '1':
            bot.send_message(chat_id = chat_id,text='⬇︎ ⚜️BTS&P 模擬 ⎨價值投資⎬ Chuck Akre  的過去1年績效走勢 \n\n\t\t\t»點選圖可放大檢視')
            bot.send_photo(chat_id = chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/Akre_1.png')
        elif key == '3':
            bot.send_message(chat_id = chat_id,text='⬇︎ ⚜️BTS&P 模擬 ⎨價值投資⎬ Chuck Akre  的過去3年績效走勢 \n\n\t\t\t»點選圖可放大檢視')
            bot.send_photo(chat_id = chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/Akre_3.png')
        elif key == '10':
            bot.send_message(chat_id = chat_id,text='⬇︎ ⚜️BTS&P 模擬 ⎨價值投資⎬ Chuck Akre  的過去10年績效走勢 \n\n\t\t\t»點選圖可放大檢視')
            bot.send_photo(chat_id = chat_id, photo='https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/chatbot/img/Akre_10.png')



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