package
{
    import com.adobe.serialization.json.JSON;
    
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFormat;
    
    public class ApplicationJSON extends Sprite
    {
        private var textField:TextField = new TextField();
        
        public function ApplicationJSON():void
        {
            var source:* = {ab:[1,"b c",{"d\"e":'f\'g', g:-1.1}, true, false]};
            var json:String = com.adobe.serialization.json.JSON.encode(source);
            var result:* = com.adobe.serialization.json.JSON.decode(json);
            
            textField.defaultTextFormat = new TextFormat(null, 15);
            textField.appendText(json);
            textField.appendText("\n");
            textField.appendText("result.ab: " + result.ab.toString());
            textField.appendText("\n");
            textField.appendText("result.ab[2]['d\"e']: " + result.ab[2]['d\"e'].toString());
            textField.appendText("\n");
            textField.appendText("result.ab[3]: " + result.ab[3].toString());
            textField.appendText("\n");
            textField.appendText("result.ab[4]: " + result.ab[4].toString());
            textField.width = stage.stageWidth;
            textField.height = stage.stageHeight;
            addChild(textField);
        }
    }
}