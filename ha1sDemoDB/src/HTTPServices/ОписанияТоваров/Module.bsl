
Функция ВызовМетодаPOST(Запрос)
	
	Перем Ответ;
	
	
	Артикул = Запрос.ПараметрыЗапроса.Получить("Article");
	Если Артикул = Неопределено Тогда
		Ответ = Новый HTTPСервисОтвет(400);
		Ответ.УстановитьТелоИзСтроки("Не задан параметр Article");
		Возврат Ответ;
	КонецЕсли;
	
	Товар = ПолучитьТоварПоАртикулу(Артикул);
	Если Товар = Неопределено Тогда
		Ответ = Новый HTTPСервисОтвет(404);	
		Ответ.УстановитьТелоИзСтроки("Товар не найден");
		Возврат Ответ;
	КонецЕсли;
	
	ИмяМетода = Запрос.ПараметрыURL["ИмяМетода"];
	
	Если ИмяМетода = "SetDescription" Тогда
		ТипСодержимого = Запрос.Заголовки.Получить("Content-Type");
		Если ТипСодержимого <> "text/html" И  ТипСодержимого <> "text/plain" Тогда
			// Сообщаем клиенту, что не поддерживаем такой тип содержимого
			Ответ = Новый HTTPСервисОтвет(415);	
		Иначе
			Товар.Описание = Запрос.ПолучитьТелоКакСтроку();
			Товар.Записать();
			Ответ = Новый HTTPСервисОтвет(204);	
		КонецЕсли;			
	ИначеЕсли ИмяМетода = "GetDescription" Тогда
		Ответ = Новый HTTPСервисОтвет(200);
		Ответ.УстановитьТелоИзСтроки(Товар.Описание);
		Ответ.Заголовки["Content-Type"] = "text/html";
	Иначе
		Ответ = Новый HTTPСервисОтвет(404);
		Ответ.УстановитьТелоИзСтроки("Неизвестное имя метода");
	КонецЕсли;
	
	
	Возврат Ответ;
КонецФункции



Функция ПолучитьТоварПоАртикулу(Артикул)

	ТекстЗапроса = "ВЫБРАТЬ Ссылка 
	        | ИЗ Справочник.Товары 
			| ГДЕ Артикул = &Артикул";
			
	Запрос = Новый Запрос(ТекстЗапроса);
	Запрос.УстановитьПараметр("Артикул", Артикул);
	
	Результат = Запрос.Выполнить();
	Выборка = Результат.Выбрать();
	
	Если Выборка.Следующий() Тогда
		Возврат Выборка.Ссылка.ПолучитьОбъект();
	Иначе
		Возврат Неопределено;
	КонецЕсли;			

КонецФункции
 
