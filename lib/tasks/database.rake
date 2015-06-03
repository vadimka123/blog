namespace :database do

  desc 'Заполнение БД'

  task zap: :environment do
    ############################################################################################################
    cat1 = Category.create(name: 'IT')
    av_1 = File.new('franck.jpeg', 'r')
    user_1 = User.create(name: 'franck', email: 'franck@mail.ru', password: 'qaz123', password_confirmation: 'qaz123', avatar: av_1)
    av_2 = File.new('pablo.jpeg', 'r')
    user_2 = User.create(name: 'pablo', email: 'pablo@mail.ru', password: 'qaz123', password_confirmation: 'qaz123', avatar: av_2)
    tag_1 = Tag.create(tag: '.NET')
    tag_2 = Tag.create(tag: 'C#')
    comment_1 = Comment.create(text: 'Это было очень приятное и быстрое видео. Способ продвинутся!!', datetime: DateTime.new(2015, 04, 15, 12, 23), user_id: user_1.id)
    comment_2 = Comment.create(text: 'спасибо за ответ :)', datetime: DateTime.new(2015, 04, 15, 12, 24), user_id: user_2.id)
    date_p = Date.parse('15-04-2015')
    Iframe.create(category_id: [cat1.id],
                       tag_id: [tag_1.id, tag_2.id],
                       comment_id: [comment_1.id, comment_2.id],
                       title: 'Принципы построения многопоточных десктопных .NET-приложений',
                       text: 'Мне с моим бэкграундом было интересно сравнить средства многопоточности, которые дает платформа .NET, со средствами, предоставляемыми платформой Java. Поймал себя на мысли, что порекомендовал посмотреть этот доклад некольким знакомым джавистам.',
                       date: date_p,
                       href: 'https://www.youtube.com/watch?v=g_Fmx4_h-5M')

    cat2 = Category.create(name: 'Музыка')
    tag_3 = Tag.create(tag: 'Louna')
    date_p = Date.parse('14-04-2015')
    Iframe.create(category_id: [cat2.id],
              tag_id: [tag_3.id],
              comment_id: [],
              title: 'Green Grey готовят новое шоу на свой ДР',
              text: 'Ветераны украинской альт-сцены Green Grey приглашают на праздничный концерт, посвященный 22-й годовщине появления группы. Шоу состоится 13 июня в киевском клубе Atlas.',
              date: date_p,
              href: '<iframe src="https://w.soundcloud.com/player/?url=https://soundcloud.com/rockeritoo/green-day-21-guns-1&amp;output=embed"></iframe>')

    img_1 = File.new('1.jpg', 'r')
    tag_4 = Tag.create(tag: 'Вирус')
    date_p = Date.parse('13-04-2015')
    Standart.create(category_id: [cat1.id],
                tag_id: [tag_4.id],
                comment_id: [],
                title: 'Новый вирус, выводящий из строя компьютер при своем обнаружении',
                text: 'Вирус, названный Cisco Systems как Rombertik, перехватывает любой, даже самый простой текст, введенный в окне браузера. Далее, в соответствии с сообщением блога Cisco’s Talos Group, датируемым этим понедельником, вирус распространяется через спам и фишинговые письма.',
                date: date_p,
                image: img_1)

    img_2 = File.new('2.jpg', 'r')
    img1 = Image.create(image: img_2)
    img_3 = File.new('3.jpg', 'r')
    img2 = Image.create(image: img_3)
    img_4 = File.new('4.jpg', 'r')
    img3 = Image.create(image: img_4)
    tag_5 = Tag.create(tag: 'Node.js')
    date_p = Date.parse('12-04-2015')
    Gallery.create(category_id: [cat1.id],
                   tag_id: [tag_5.id],
                   comment_id: [],
                   title: 'Разработка на Node.js',
                   text: 'C момента появления Node.js его и критикуют, и превозносят. Споры о достоинствах и недостатках этого инструмента не утихают и, вероятно, не утихнут в ближайшее время. Однако часто мы упускаем из виду, что критика любого языка или платформы основывается на возникающих проблемах, зависящих от того, как мы эти платформы используем.',
                   date: date_p,
                   image_id: [img1.id, img2.id, img3.id])
  end

end