
&Желудь
Процедура ПриСозданииОбъекта()
	
КонецПроцедуры

Функция СформироватьПараметрыТочкиМаршрута(Действие, ТребуемыеПараметры, ВходящийЗапрос, Ответ, Сессия) Экспорт

	ЗначенияПараметров = СтруктураЗначенийПараметровДляТочкиМаршрута(ВходящийЗапрос, Ответ, Сессия);

	Если Действие.УрлСодержитШаблон Тогда
		ПутьСПараметрами = ПараметрыИзУрлаСШаблоном(ВходящийЗапрос.Путь, Действие.АдресКонтроллера);
		ДополнитьЗначениямиПараметровУРЛ(Действие.ПараметрыУРЛ, ПутьСПараметрами, ЗначенияПараметров);
	КонецЕсли;

	Возврат СформироватьМассивНеобходимыхПараметров(ТребуемыеПараметры, ЗначенияПараметров);
	
КонецФункции

Функция ПараметрыИзУрлаСШаблоном(Путь, АдресКонтроллера)
	Если АдресКонтроллера = "/" Тогда
		Возврат Сред(Путь, 2);
	Иначе
		Возврат СтрЗаменить(Путь, АдресКонтроллера + "/", "");
	КонецЕсли;
КонецФункции

Функция СформироватьМассивНеобходимыхПараметров(ТребуемыеПараметры, Значения) Экспорт
	Результат = Новый Массив();
	
	Для Каждого Параметр из ТребуемыеПараметры Цикл
		Значение = Неопределено;
		Если Не Значения.Свойство(Параметр, Значение) Тогда
			ВызватьИсключение СтрШаблон("Неизвестный параметр <%1>", Параметр);
		КонецЕсли;
		Результат.Добавить(Значение);
	КонецЦикла;

	Возврат Результат;	
КонецФункции

Процедура ДополнитьЗначениямиПараметровУРЛ(ПараметрыУРЛ, Путь, ЗначенияПараметров)
	ПутьВМассив = СтрРазделить(Путь, "/");

	Для каждого ТекПараметрУРЛ Из ПараметрыУРЛ Цикл

		Если ТекПараметрУРЛ.Ключ <= ПутьВМассив.ВГраница() Тогда
			ЗначенияПараметров.Вставить(ТекПараметрУРЛ.Значение, ПутьВМассив[ТекПараметрУРЛ.Ключ]);
		Иначе
			ЗначенияПараметров.Вставить(ТекПараметрУРЛ.Значение);
		КонецЕсли;

	КонецЦикла;
КонецПроцедуры

Функция СтруктураЗначенийПараметровДляТочкиМаршрута(ВходящийЗапрос, Ответ, Сессия)
	Значения = Новый Структура();	
	ДополнитьСтруктуру(Значения, ВходящийЗапрос.ЗначенияПараметровДляТочкиМаршрута());
	ДополнитьСтруктуру(Значения, Ответ.ЗначенияПараметровДляТочкиМаршрута());
	ДополнитьСтруктуру(Значения, Сессия.ЗначенияПараметровДляТочкиМаршрута());
	ДополнитьСтруктуру(Значения, ВходящийЗапрос.ПараметрыИменные);
	Возврат Значения;
КонецФункции

Процедура ДополнитьСтруктуру(СтруктураПриемник, СтруктураИсточник)
	Для Каждого КиЗ Из СтруктураИсточник Цикл
		СтруктураПриемник.Вставить(КиЗ.Ключ, КиЗ.Значение);
	КонецЦикла;
КонецПроцедуры