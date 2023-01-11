Fremgangsmåde:

	$ jing -c rnc/dsl-basis.rnc example.xml


Bruger man XML-redigeringsprogrammet Oxygen, og har man skemaet
lokalt, kan man forsyne det XML-dokument, man vil validere med DSL-TEI-skemaet med denne
processing instruction

```xml
<?oxygen RNGSchema="file:///home/th/Development/dsl-tei/rnc/dsl-tei.rnc" type="compact"?>
```
