&Пластилин Перем ШифрованиеВебСокета;

&Пластилин Перем КонструкторыПараметров;
&Пластилин Перем СоединенияВебСокетов;

Перем Рефлектор;
Перем КешОбработчиков;
Перем ПодпискиПодключения;
Перем ПодпискиОтключения;
Перем _Маршрутизатор;

&Желудь
Процедура ПриСозданииОбъекта(&Пластилин Перечисления, &Пластилин Маршрутизатор)
	Рефлектор = Новый Рефлектор();	
	КешОбработчиков = Новый Соответствие();
	_Маршрутизатор = Маршрутизатор;

	ПодпискиПодключения = Маршрутизатор.ПолучитьПодписки(Перечисления.ВидыПодписокВебСокета.ПриПодключенииВебСокета);
	ПодпискиОтключения = Маршрутизатор.ПолучитьПодписки(Перечисления.ВидыПодписокВебСокета.ПриОтключенииВебСокета);
КонецПроцедуры

Процедура ВходящееСообщение(Идентификатор, Топик, ДвоичныеДанныеСообщения) Экспорт

	ДанныеСообщения = ШифрованиеВебСокета.РаспаковатьСообщение(ДвоичныеДанныеСообщения);

	Если ДанныеСообщения.ТипСообщения = 0 Тогда // Продолжение

	ИначеЕсли ДанныеСообщения.ТипСообщения = 1 Тогда // Текстовый фрейм

		Обработчик = НайтиОбработчик(Топик);
		Параметры = КонструкторыПараметров.СформироватьМассивНеобходимыхПараметров(Обработчик.Действие.Параметры, 
																					Новый Структура("Идентификатор, Топик, Сообщение", 
																									Идентификатор, 
																									Топик, 
																									ДанныеСообщения.Сообщение));

		Рефлектор.ВызватьМетод(Обработчик.Действие.Желудь, Обработчик.Действие.ИмяМетода, Параметры);	

	ИначеЕсли ДанныеСообщения.ТипСообщения = 2 Тогда // бинарные данные

	ИначеЕсли ДанныеСообщения.ТипСообщения = 3 Тогда //

	ИначеЕсли ДанныеСообщения.ТипСообщения = 4 Тогда//

	ИначеЕсли ДанныеСообщения.ТипСообщения = 5 Тогда //

	ИначеЕсли ДанныеСообщения.ТипСообщения = 6 Тогда //

	ИначеЕсли ДанныеСообщения.ТипСообщения = 7 Тогда //

	ИначеЕсли ДанныеСообщения.ТипСообщения = 8 Тогда // Закрытие соединения
		// СоединенияВебСокетов.НайтиИЗакрытьСоединениеПоИдентификаторуИТопику(Топик, Идентификатор);
	ИначеЕсли ДанныеСообщения.ТипСообщения = 9 Тогда // Пинг

	ИначеЕсли ДанныеСообщения.ТипСообщения = 10 Тогда // Понг

	ИначеЕсли ДанныеСообщения.ТипСообщения = 11 Тогда //

	ИначеЕсли ДанныеСообщения.ТипСообщения = 12 Тогда //

	ИначеЕсли ДанныеСообщения.ТипСообщения = 13 Тогда //

	ИначеЕсли ДанныеСообщения.ТипСообщения = 14 Тогда //

	ИначеЕсли ДанныеСообщения.ТипСообщения = 15 Тогда //

	ИначеЕсли ДанныеСообщения.ТипСообщения = 16 Тогда //

	КонецЕсли;

КонецПроцедуры

Процедура ОтправитьСообщение(Топик, Сообщение, Идентификатор) Экспорт
	ДанныеСоединения = СоединенияВебСокетов.ПолучитьСоединениеПоИдентификатору(Топик, Идентификатор);
	Если НЕ ДанныеСоединения = Неопределено Тогда
		УпакованноеСообщение = ШифрованиеВебСокета.ЗапаковатьСообщениеТекстовоеСообщение(Сообщение);
		ДанныеСоединения.Соединение.ОтправитьДвоичныеДанные(УпакованноеСообщение);
	КонецЕсли;
КонецПроцедуры

Процедура ОтправитьСообщениеВсем(Топик, Сообщение) Экспорт
	Соединения = СоединенияВебСокетов.ПолучитьСоединенияПоТопику(Топик);
	УпакованноеСообщение = ШифрованиеВебСокета.ЗапаковатьСообщениеТекстовоеСообщение(Сообщение);
	Для Каждого ДанныеСоединения из Соединения Цикл
		ДанныеСоединения.Соединение.ОтправитьДвоичныеДанные(УпакованноеСообщение);
	КонецЦикла;
КонецПроцедуры

Процедура ОтправитьСообщениеСписку(Топик, Сообщение, СписокИдентификаторов) Экспорт
	Соединения = СоединенияВебСокетов.ПолучитьСоединенияПоТопикуСпискуИдентификаторов(Топик, СписокИдентификаторов);
	УпакованноеСообщение = ШифрованиеВебСокета.ЗапаковатьСообщениеТекстовоеСообщение(Сообщение);
	Для Каждого ДанныеСоединения из Соединения Цикл
		ДанныеСоединения.Соединение.ОтправитьДвоичныеДанные(УпакованноеСообщение);
	КонецЦикла;
КонецПроцедуры

Процедура ОтправитьСообщениеВсемКроме(Топик, Сообщение, СписокИсключенийИдентификаторов) Экспорт
	Соединения = СоединенияВебСокетов.ПолучитьСоединенияПоТопикуКромеСпискаИдентификаторов(Топик, СписокИсключенийИдентификаторов);
	УпакованноеСообщение = ШифрованиеВебСокета.ЗапаковатьСообщениеТекстовоеСообщение(Сообщение);
	Для Каждого ДанныеСоединения из Соединения Цикл
		ДанныеСоединения.Соединение.ОтправитьДвоичныеДанные(УпакованноеСообщение);
	КонецЦикла;
КонецПроцедуры

Процедура ПриПодключении(Топик, Идентификатор) Экспорт
	ОбработатьСобытиеПодписки(Топик, Идентификатор, ПодпискиПодключения);
КонецПроцедуры

Процедура ПриОтключении(Топик, Идентификатор) Экспорт
	ОбработатьСобытиеПодписки(Топик, Идентификатор, ПодпискиОтключения);
КонецПроцедуры

Процедура ОбработатьСобытиеПодписки(Топик, Идентификатор, ПодпискиВебСокета)
	ОписаниеПодписки = ПодпискиВебСокета.Получить(Топик);
	Если не ОписаниеПодписки = Неопределено Тогда
		Параметры = КонструкторыПараметров.СформироватьМассивНеобходимыхПараметров(ОписаниеПодписки.Параметры, 
																Новый Структура("Идентификатор", Идентификатор));
		Рефлектор.ВызватьМетод(ОписаниеПодписки.Объект, ОписаниеПодписки.Метод, Параметры);
	КонецЕсли;
КонецПроцедуры

Функция НайтиОбработчик(Топик)

	Обработчик = КешОбработчиков.Получить(Топик);
	Если Обработчик = Неопределено Тогда
		Обработчик = _Маршрутизатор.НайтиОбработчикИПараметрыПоПолномуПути(Топик);
		КешОбработчиков.Вставить(Топик, Обработчик);
	КонецЕсли;

	Возврат Обработчик;
	
КонецФункции