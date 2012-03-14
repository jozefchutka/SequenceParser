package
{
    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.text.TextField;
    import flash.text.TextFieldType;
    import flash.text.TextFormat;
    import flash.ui.Keyboard;
    
    import sk.yoz.data.sequenceParser.simpleQuery.SimpleQueryParser;
    
    public class ApplicationSimpleQuery extends Sprite
    {
        private var textField:TextField = new TextField;
        private var textInput:TextField = new TextField;
        
        public function ApplicationSimpleQuery():void
        {
            textInput.width = stage.stageWidth - 1;
            textInput.height = 23;
            textInput.type = TextFieldType.INPUT;
            textInput.text = "a b    c anD b or     (c ed Or ((a) AND de*f) and andor)";
            textInput.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
            textInput.border = true;
            addChild(textInput)
            
            textField.y = 25;
            textField.width = stage.stageWidth;
            textField.height = stage.stageHeight - 25;
            textField.wordWrap = true;
            textField.multiline = true;
            textField.defaultTextFormat = new TextFormat(null, 13);
            addChild(textField);
            
            parse();
        }
        
        private function onKeyDown(event:KeyboardEvent):void
        {
            if(event.keyCode == Keyboard.ENTER)
                parse();
        }
        
        
        private function parse():void
        {
            var input:String = textInput.text;
            var output:String;
            try
            {
                output = SimpleQueryParser.parse(input, expressionCallback);
            }
            catch(error:Error)
            {
                output = error.message;
            }
            textField.htmlText = output + 
                "\n\nupdate text input and hit enter.";
        }
        
        private function expressionCallback(value:String):String
        {
            return "<b><u>" + value + "</u></b>";
        }
    }
}