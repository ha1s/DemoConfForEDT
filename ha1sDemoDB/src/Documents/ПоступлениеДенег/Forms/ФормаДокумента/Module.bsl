&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	
	ПараметрыОпций = Новый Структура("Организация", Объект.Организация);
	УстановитьПараметрыФункциональныхОпцийФормы(ПараметрыОпций);
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Ключ.Пустая() Тогда 
		
		ПараметрыОпций = Новый Структура("Организация", Объект.Организация);
		УстановитьПараметрыФункциональныхОпцийФормы(ПараметрыОпций);
		
	КонецЕсли;
	
КонецПроцедуры


&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	ПараметрыОпций = Новый Структура("Организация", Объект.Организация);
	УстановитьПараметрыФункциональныхОпцийФормы(ПараметрыОпций);

КонецПроцедуры


&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	ПараметрыОпций = Новый Структура("Организация", Объект.Организация);
	УстановитьПараметрыФункциональныхОпцийФормы(ПараметрыОпций);
	
КонецПроцедуры
