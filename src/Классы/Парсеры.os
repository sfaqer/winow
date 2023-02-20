Перем Перечисления;

&Желудь
Процедура ПриСозданииОбъекта(
							&Пластилин("Перечисления") _Перечисления
							)
	Перечисления = _Перечисления;
КонецПроцедуры

Функция ПараметрыИзТекста(ПараметрыТекстом) Экспорт

	Результат = Новый Соответствие();
	
	Если ЗначениеЗаполнено(ПараметрыТекстом) Тогда
		МассивПараметров = СтрРазделить(ПараметрыТекстом, "&", Ложь);
		Для Каждого ТекПараметрСтрокой из МассивПараметров Цикл
			ТекПараметр = РазделитьСтроку(ТекПараметрСтрокой, "=");
			Результат.Вставить(ТекПараметр.Лево, ТекПараметр.Право);
		КонецЦикла;
	КонецЕсли;

	Возврат Результат;
	
КонецФункции

Функция РазделитьСтроку(Строка, Разделитель) Экспорт
	Результат = Новый Структура("Лево, Право","","");
	ПозицияРазделителя = СтрНайти(Строка, Разделитель);

	Если ПозицияРазделителя = 0 Тогда
		Результат.Лево = Строка;
	Иначе
		Результат.Лево = Лев(Строка, ПозицияРазделителя - 1);
		Результат.Право = Сред(Строка, ПозицияРазделителя + СтрДлина(Разделитель));
	КонецЕсли;

	Возврат Результат;
КонецФункции

Функция РазделитьДвоичныеДанныеРазделителем(ДвоичныеДанные, Разделитель) Экспорт
	БайтыРазделителя = ПолучитьМассивБайт(Разделитель);
	ТекущийПорядокБайт = Новый Массив(БайтыРазделителя.Количество());
	Лево = Неопределено;
	Право = Неопределено;
	Чтение = Новый ЧтениеДанных(ДвоичныеДанные);

	Пока не Чтение.ЧтениеЗавершено Цикл
		ТекБайт = Чтение.Прочитать(1).ПолучитьДвоичныеДанные();
		ДобавитьВМассивСоСмещением(ТекущийПорядокБайт, ТекБайт);

		Если МассивыРавны(БайтыРазделителя, ТекущийПорядокБайт) Тогда
			Право = Чтение.Прочитать().ПолучитьДвоичныеДанные();
			Чтение.Закрыть();
			Прервать;
		КонецЕсли;
	КонецЦикла;

	Чтение = Новый ЧтениеДанных(ДвоичныеДанные);

	Если Право = Неопределено или Право.Размер() = 0 Тогда
		Лево = Чтение.Прочитать().ПолучитьДвоичныеДанные();
	Иначе
		ЧитатьПо = ДвоичныеДанные.Размер() - Разделитель.Размер() - Право.Размер();
		Лево = Чтение.Прочитать(ЧитатьПо).ПолучитьДвоичныеДанные();
	КонецЕсли;

	Возврат Новый Структура("Лево, Право", Лево, Право);

КонецФункции

Функция МассивыРавны(Массив1, Массив2) Экспорт

	Если не Массив1.Количество() = Массив2.Количество() Тогда
		Возврат Ложь;
	Иначе
		Для сч = 0 По Массив1.ВГраница() Цикл
			Если Не Массив1[сч] = Массив2[сч] Тогда
				Возврат Ложь;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;

	Возврат Истина;
	
КонецФункции

Процедура ДобавитьВМассивСоСмещением(Массив, ДобавляемыйЭлемент) Экспорт
	
	Если Массив.Количество() = 1 Тогда
		Массив[0] = ДобавляемыйЭлемент;
		Возврат;
	ИначеЕсли Массив.Количество() = 0 Тогда
		ВызватьИсключение "Пустой массив для смещения";
	КонецЕсли;

	Для сч = 0 по Массив.ВГраница() - 1 Цикл
		Массив[сч] = Массив[сч + 1];
	КонецЦикла;

	Массив[Массив.ВГраница()] = ДобавляемыйЭлемент;

КонецПроцедуры

Функция ПолучитьМассивБайт(ДвоичныеДанные) Экспорт

	Возврат РазделитьДвоичныеДанные(ДвоичныеДанные, 1);

КонецФункции