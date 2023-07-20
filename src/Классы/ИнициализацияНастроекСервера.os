&Пластилин(Значение = "Контроллер", Тип = "Массив")
Перем Контроллы;

&Пластилин Перем РегистраторКаталогаФайлов;
&Пластилин Перем СборщикМаршрутов;
&Пластилин Перем ВебСервер;

&Деталька("winow.КаталогиСФайлами")
Перем КаталогиСФайлами;

&Деталька(Значение = "winow.АвтоСтарт", ЗначениеПоУмолчанию = Ложь)
Перем АвтоСтарт;

&Рогатка
Процедура ПриСозданииОбъекта() 
	
КонецПроцедуры

Процедура ПриЗапускеПриложения() Экспорт
	
	Для Каждого Контролл из Контроллы Цикл
		СборщикМаршрутов.НайтиИЗарегистрироватьМаршруты(Контролл);
	КонецЦикла;

	Если ТипЗнч(КаталогиСФайлами) = Тип("Соответствие") Тогда
		Для Каждого КиЗ из КаталогиСФайлами Цикл
			РегистраторКаталогаФайлов.ДобавитьКаталогСтатичныхФайлов(КиЗ.Значение, КиЗ.Ключ);
		КонецЦикла;
	КонецЕсли;

	Старт();

КонецПроцедуры

Процедура Старт()

	Если АвтоСтарт = Истина Тогда
		ВебСервер.Старт();
	КонецЕсли;
	
КонецПроцедуры