# BlogNotik

Функционально новый подход к блогам

## Локальный запуск

Для запуска необходимы установленные Ruby, [EchoPrint-Codegen](https://github.com/echonest/echoprint-codegen) в Вашем `$PATH` и FFmpeg.

```sh
$ git clone https://github.com/vadimka123/blog.git
$ cd blog
$ bundle install
$ rake db:create
$ rake database:zap
$ rails server
```

Приложение будет доступно по адрессу [localhost:3000](http://localhost:3000/).


