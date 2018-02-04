//////////////////////////////////////////////////////////////////////////////// 
// ВСПОМОГАТЕЛЬНЫЕ ПРОЦЕДУРЫ И ФУНКЦИИ
//

&НаКлиенте
Процедура ВыбратьНастройку()

	Если Элементы.СписокНастроек.ТекущаяСтрока <> Неопределено Тогда 

		Закрыть(Новый ВыборНастроек(Элементы.СписокНастроек.ТекущиеДанные.Значение));

	Иначе

		Закрыть();

	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокНастроек()

	СписокНастроек = Новый СписокЗначений;

	Для каждого Элемент Из СтандартныеНастройки Цикл

		СписокНастроек.Добавить(Элемент.Значение, Элемент.Представление);

	КонецЦикла;

	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ХранилищеВариантовОтчетов.Код КАК Код,
	               |	ХранилищеВариантовОтчетов.Наименование КАК Наименование
	               |ИЗ
	               |	Справочник.ХранилищеВариантовОтчетов КАК ХранилищеВариантовОтчетов
	               |ГДЕ
	               |	ХранилищеВариантовОтчетов.КлючОбъекта = &КлючОбъекта";

	Запрос.Параметры.Вставить("КлючОбъекта", КлючОбъекта);

	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();

	Пока Выборка.Следующий() Цикл

		СписокНастроек.Добавить(Выборка.Код, Выборка.Наименование);

	КонецЦикла;

	СписокНастроек.СортироватьПоПредставлению();

КонецПроцедуры

&НаСервере
Процедура УдалитьНастройку(Ключ)

	УдаляемыйЭлемент = Справочники.ХранилищеВариантовОтчетов.НайтиПоКоду(Ключ);

	Если УдаляемыйЭлемент <> Справочники.ХранилищеВариантовОтчетов.ПустаяСсылка() Тогда

		УдаляемыйЭлемент.ПолучитьОбъект().Удалить();
		ЗаполнитьСписокНастроек();

	КонецЕсли;

КонецПроцедуры

//////////////////////////////////////////////////////////////////////////////// 
// ОБРАБОТЧИКИ СОБЫТИЙ
//

&НаКлиенте
Процедура ЗагрузитьВыполнить()

	ВыбратьНастройку();

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	КлючОбъекта = Параметры.КлючОбъекта;
	КлючТекущихНастроек = Параметры.КлючТекущихНастроек;
	СтандартныеНастройки = Параметры.СтандартныеНастройки;

	ЗаполнитьСписокНастроек();

	Элемент = СписокНастроек.НайтиПоЗначению(КлючТекущихНастроек);
	Если Элемент <> Неопределено Тогда

		Элементы.СписокНастроек.ТекущаяСтрока = Элемент.ПолучитьИдентификатор();

	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура СписокНастроекПередНачаломИзменения(Элемент, Отказ)

	Отказ = Истина;

КонецПроцедуры

&НаКлиенте
Процедура СписокНастроекПередУдалением(Элемент, Отказ)

	Отказ = Истина;

	Если Элементы.СписокНастроек.ТекущаяСтрока <> Неопределено Тогда

		Если СтандартныеНастройки.НайтиПоЗначению(СписокНастроек.НайтиПоИдентификатору(Элементы.СписокНастроек.ТекущаяСтрока).Значение) <> Неопределено Тогда

			ПоказатьПредупреждение(, НСтр("ru = ""Стандартный вариант не может быть удален"""), Неопределено);

		Иначе
			Оповещение = Новый ОписаниеОповещения(
				"СписокНастроекПередУдалениемВопросЗавершение",
				ЭтотОбъект);

			ПоказатьВопрос(Оповещение,
				НСтр("ru = ""Удалить вариант """) + СписокНастроек.НайтиПоИдентификатору(Элементы.СписокНастроек.ТекущаяСтрока).Представление + "?",
				РежимДиалогаВопрос.ДаНет);

		КонецЕсли;

	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура СписокНастроекПередУдалениемВопросЗавершение(Результат, Параметры) Экспорт
	Если Результат = КодВозвратаДиалога.Да Тогда
		УдалитьНастройку(
			СписокНастроек.НайтиПоИдентификатору(
				Элементы.СписокНастроек.ТекущаяСтрока).Значение);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура СписокНастроекВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)

	СтандартнаяОбработка = Ложь;
	ВыбратьНастройку();

КонецПроцедуры

&НаКлиенте
Процедура СписокНастроекПередНачаломДобавления(Элемент, Отказ, Копирование)

	Отказ = Истина;

КонецПроцедуры
