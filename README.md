# ws-example
![logo](https://github.com/ChaserVasya/ws-example/assets/74578917/ca57c0d5-7541-4b32-811a-1216be08d9e2)

### Клиент
- Приложение содержит таблицу 3х3.
- Каждая ячейка содержит текстовое поле.
- Текст фиксируется только тогда, когда нажата клавиша на клавиатуре "Представить (Submit)". Если клавиша ненажата, текст считается "черновым" и не фиксируется приложением. И удалится при обновлении от других пользователей.
- В случае, если нет интернета, данные не фиксируются. Для переподключения к серверу есть клавиша "Переподписаться" (значок "Refresh" в AppBar справа).
- В случай ошибок выскакивает SnackBar с текущей ошибкой.
- Если несколько клиентов отправляют сообщения, они последовательно обрабатываются блоком с помощью `bloc_concurency - sequential`. Это поможет избежать неоднозначного поведения при потенциальном масштабировании.
<img src="https://github.com/ChaserVasya/ws-example/assets/74578917/e62515e2-eb08-4ae4-b9fc-5e1d5585794f"  width="40%" height="20%">

### Сервер
- Сервер сделан на dart_frog, размещён на публичном VPS и запущен с помощью Docker.
- Содержит в себе глобальные состояния: текущее состояние таблицы и подключения.
- При подключении к серверу клиенту отправляется текущее состояние таблицы.
- При отключении от сервера соединение удаляется.

### Возможные улучшения
- На данный момент отправляются данные всей таблицы во всех случаях. Это сделано для консистентности данных на всех клиентах. Есть вариант, отправлять только изменённую ячейку. Но здесь нужно проводить много исследований, чтобы гарантировать доставки актуального состояния таблицы на всех клиентах. Конечно же, если бы таблица содержала не 9 ячеек, а 50, это бы было сделано обязательно. Но для демонстрационного приложения "на пару дней" текущего решения вполне достаточно.
- Общие модели, `Codec`и, следует вынести в библиотеку, типа, `common`. Но для демонстрационного приложения модели и мапперы дублируются.


