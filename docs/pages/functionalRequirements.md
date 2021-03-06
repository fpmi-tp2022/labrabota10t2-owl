# Функциональные требования

[Home](../index.md)    
[Функциональные требования](functionalRequirements.md)  
[Диаграмма файлов приложения](applicationFileDiagram.md)  
[Дополнительная спецификация](additionalSpecification.md)   
[Схема базы данных](databaseSchema.md)  
[Презентация проекта](projectPresentation.md)   

# Функциональные требования

#### Приложение должно позволять пройти регистрацию и авторизацию пользователя.

#### Приложение должно выполнять следующие функции:
1. Поиск ближайших взрослой и детской поликлиник по местоположению пользователя.
2. Сохранение взрослой и детской поликлиник пользователя.
3. Вывод списка больниц города и дополнительной информации о них.
4. Вывод доступных талонов для заказа.
5. Функционал, который отвечает за заказ талона к определенному специалисту.
6. Функционал, который отвечает за отмену заказанного талона.
7. Вывод заказанных талонов пользователя.

#### Use Case диаграмма:
![Use_Case](https://user-images.githubusercontent.com/78850640/173029703-151a58dd-8f70-42bc-a53a-2165b758d36b.png)

#### Сценарий для пользователя:
1. Пользователь регистрируется в приложении или вводит логин и пароль, проходя авторизацию.
2. Затем отображается карта с ближайшими взрослой и детской поликлиниками пользователя.
3. Пользователь может сохранить выбор поликлиник программой или может сам осуществить выбор поликлиник из списка или по карте.
4. Далее пользователь может выбрать одну из следующих опций:
* Войти в раздел "Моя поликлиника" и заказать талон к специалисту.
* Войти в раздел "Детская поликлиника" и заказать талон к специалисту.
* Войти в раздел "Больницы" и просмотреть информацию о больницах города.
* Войти в раздел "Мои талоны" и просмотреть заказанные талоны или отменить заказ талонов.
5. Взаимодействуя с системой, пользователь работает с приложением.
