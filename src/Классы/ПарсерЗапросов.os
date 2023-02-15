Перем Поделка;
Перем Перечисления;
Перем Парсеры;
Перем Настройки;

&Пластилин Перем ОбработчикЗапросов;
&Пластилин Перем ПодготовительОтветов;
&Пластилин Перем МенеджерСессий;
&Пластилин Перем ФабрикаОтветов;

&Желудь
Процедура ПриСозданииОбъекта(
							&Пластилин("Поделка") _Поделка,
							&Пластилин("Перечисления") _Перечисления,
							&Пластилин("Парсеры") _Парсеры,
							&Пластилин("Настройки") _Настройки
							)
	Поделка = _Поделка;
	Перечисления = _Перечисления;
	Парсеры = _Парсеры;
	Настройки = _Настройки;
КонецПроцедуры

Функция ОбработатьДвоичныеДанные(ДвоичныеДанныеЗапроса) Экспорт

	Запрос = ПолучитьЗапросИзДвоичныхДанных(ДвоичныеДанныеЗапроса);

	УстановитьСессиюПоКукам(Запрос);

	Результат = СтруктураРезультатаПарсинга();

	Если Запрос.ЭтоЗапросНаВебСокет() Тогда
		Ответ = ФабрикаОтветов.ОтветРукопожатияВебСокета(Запрос);
		
		Результат.Идентификатор = Запрос.Сессия.Идентификатор();
		Результат.ЗакрыватьСоединение = Ложь;
		Результат.Топик = Запрос.Путь;
	Иначе
		Ответ = ОбработчикЗапросов.СформироватьОтвет(Запрос);
	КонецЕсли;

	Результат.Ответ = ПодготовительОтветов.ДвоичныеДанныеОтвета(Ответ); 

	Возврат Результат;
	
КонецФункции

Функция ПолучитьЗапросИзДвоичныхДанных(ДвоичныеДанныеЗапроса) Экспорт
	
	Запрос = Поделка.НайтиЖелудь("ВходящийЗапрос");

	ДанныеЗапроса = ДвоичныеДанныеЗапроса;

	РазделенныйЗапрос = Парсеры.РазделитьДвоичныеДанныеРазделителем(ДанныеЗапроса, Перечисления.ДвойнойРазделительДвоичнымиДанными);

	ТекстЗапроса = ПолучитьСтрокуИзДвоичныхДанных(РазделенныйЗапрос.Лево, "utf-8");

	СтруктураЗапроса = РазобратьТексЗапроса(ТекстЗапроса);

	Запрос.ТекстЗапроса = ТекстЗапроса;
	Запрос.ДвоичныеДанные = ДанныеЗапроса;
	Запрос.ТелоДвоичныеДанные = РазделенныйЗапрос.Право;
	Если Не Запрос.ТелоДвоичныеДанные = Неопределено Тогда
		Запрос.Тело = ПолучитьСтрокуИзДвоичныхДанных(Запрос.ТелоДвоичныеДанные);
	КонецЕсли;

	ЗаполнитьЗначенияСвойств(Запрос, СтруктураЗапроса);

	Возврат Запрос;

КонецФункции

Функция РазобратьТексЗапроса(ТекстЗапроса)
	Результат = Новый Структура();

	МассивСтрок = СтрРазделить(ТекстЗапроса, Символы.ПС, Ложь);

	Если МассивСтрок.Количество() > 0 Тогда
		ПерваяСтрока = СтрРазделить(МассивСтрок[0], " ");
		Результат.Вставить("Метод", ПерваяСтрока[0]);
		Результат.Вставить("ПолныйПуть", РаскодироватьСтроку(ПерваяСтрока[1],СпособКодированияСтроки.КодировкаURL));
		
		ПутьИПараметры = Парсеры.РазделитьСтроку(Результат.ПолныйПуть, "?");

		Результат.Вставить("ПараметрыИменные", Парсеры.ПараметрыИзТекста(ПутьИПараметры.Право));
		Результат.Вставить("Путь", ПутьИПараметры.Лево);
		
		Заголовки = Новый Соответствие();
		Результат.Вставить("Заголовки", Заголовки);

		Результат.Вставить("Куки", Поделка.НайтиЖелудь("Куки"));

		Для Сч = 1 По МассивСтрок.ВГраница() Цикл
			ДанныеСтроки = РаспарситьСтрокуЗаголовка(МассивСтрок[Сч]);
			Если ДанныеСтроки.Имя = "Cookie" Тогда
				Для Каждого КукаСтрокой Из СтрРазделить(ДанныеСтроки.Значение, ";") Цикл
					Кука = Парсеры.РазделитьСтроку(КукаСтрокой, "=");
					Результат.Куки.Добавить(СокрЛП(Кука.Лево), СокрЛП(Кука.Право));
				КонецЦикла
			Иначе
				Заголовки.Вставить(ДанныеСтроки.Имя, ДанныеСтроки.Значение);
			КонецЕсли;
		КонецЦикла;

	КонецЕсли;

	Возврат Результат;
КонецФункции

Функция РаспарситьСтрокуЗаголовка(СтрокаЗаголовка)
	РазделеннаяСтрока = Парсеры.РазделитьСтроку(СтрокаЗаголовка, ":");
	Возврат Новый Структура("Имя, Значение", РазделеннаяСтрока.Лево, РазделеннаяСтрока.Право);
КонецФункции

Процедура УстановитьСессиюПоКукам(Запрос)
	Запрос.Сессия = МенеджерСессий.ПолучитьСессиюПоКукам(Запрос.Куки);
КонецПроцедуры

Функция СтруктураРезультатаПарсинга()
	Возврат Новый Структура("ЗакрыватьСоединение, Ответ, Идентификатор, Топик", Истина);
КонецФункции