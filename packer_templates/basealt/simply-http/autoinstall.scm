; установка языка операционной системы (ru_RU)
("/sysconfig-base/language" action "write" lang ("ru_RU"))
; установка переключателя расладки клавиатуры на Ctrl+Shift
("/sysconfig-base/kbd" action "write" layout "ctrl_shift_toggle")
; установка часового пояса в Europe/Moscow, время в BIOS будет храниться в UTC
("/datetime-installer" action "write" commit #t name "RU" zone "Europe/Moscow" utc #t)
; автоматическая разбивка жёсткого диска
("/evms/control" action "write" control open installer #t)
("/evms/control" action "write" control update)
("/evms/profiles/root" action apply commit #f clearall #t exclude ())
("/evms/control" action "write" control commit)
("/evms/control" action "write" control close)
; установка пакетов операционной системы
("pkg-init" action "write")
; установка только базовой системы (дополнительные группы пакетов из pkg-groups.tar указываются по именам через пробел)
("/pkg-install" action "write" lists "" auto #t)
("/preinstall" action "write")
; установка загрузчика GRUB в MBR на первый жёсткий диск
("/grub" action "write" device "/dev/vda" passwd #f passwd_1 "*" passwd_2 "*")
; настройка сетевого интерфейса на получение адреса по DHCP
("/net-eth" action "write" reset #t)
("/net-eth" action "write" name "eth0" configuration "dhcp" default "" search "" dns "" computer_name "alt")
("/net-eth" action "write" commit #t)
; Установка паролей
("/root/change_password" language ("ru_RU") passwd_1 "password" passwd_2 "password")
("/users/create_account" new_name "vagrant" gecos "" allow_su #t auto #f passwd_1 "password" passwd_2 "password")
