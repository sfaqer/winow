&Пластилин
Перем Лог Экспорт;

Перем КонтекстПриложения Экспорт;
Перем Настройки Экспорт;
Перем МенеджерПриложений Экспорт;
Перем СлушательПорта;
Перем ОбработчикСоединений;

&Желудь
Процедура ПриСозданииОбъекта(
							&Пластилин("КонтекстПриложения") _КонтекстПриложения,
							&Пластилин("Настройки") _Настройки,
							&Пластилин("СлушательПорта") _СлушательПорта,
							&Пластилин("ОбработчикСоединений") _ОбработчикСоединений,
							&Пластилин("МенеджерПриложений") _МенеджерПриложений,
							&Пластилин("Маршрутизатор") _Маршрутизатор,
							&Пластилин("МенеджерОтображений") _МенеджерОтображений
							)
	
	КонтекстПриложения = _КонтекстПриложения;
	Настройки = _Настройки;	
	СлушательПорта = _СлушательПорта;
	ОбработчикСоединений = _ОбработчикСоединений;
	МенеджерПриложений = _МенеджерПриложений;
	Маршрутизатор = _Маршрутизатор;
	МенеджерОтображений = _МенеджерОтображений;
КонецПроцедуры 

Процедура Старт() Экспорт

	Лог.Информация("Запускается сервер winow");

	ПрименитьНастройкиКаталогов();

	СлушательПорта.Запустить();

	Пока СлушательПорта.Активен() Цикл

		Соединение = СлушательПорта.ОжидатьСоединения();

		МассивПараметров = Новый Массив();
		МассивПараметров.Добавить(Соединение);

		Если Настройки.ЗапросВФоновыхЗаданиях = Истина Тогда

			ФоновыеЗадания.Выполнить(ОбработчикСоединений, "Обработать", МассивПараметров);
		
		Иначе

			ОбработчикСоединений.Обработать(Соединение);

		КонецЕсли;

	КонецЦикла
	
КонецПроцедуры

Процедура ПрименитьНастройкиКаталогов()

	Если ТипЗнч(Настройки.КаталогиСФайлами) = Тип("Соответствие") Тогда
		Для Каждого КаталогСФайлами из Настройки.КаталогиСФайлами Цикл
			МенеджерПриложений.ДобавитьКаталогСтатичныхФайлов(КаталогСФайлами.Значение, КаталогСФайлами.Ключ);
		КонецЦикла;
	КонецЕсли;

	Если ТипЗнч(Настройки.КаталогиСПриложениями) = Тип("Соответствие") Тогда
		Для Каждого КаталогСПриложением из Настройки.КаталогиСПриложениями Цикл
			МенеджерПриложений.ДобавитьПриложениеИзКаталога(КаталогСПриложением.Ключ, КаталогСПриложением.Значение);
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры