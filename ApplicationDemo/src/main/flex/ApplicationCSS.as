package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.text.TextField;
    import flash.text.TextFormat;
    
    import sk.yoz.data.sequenceParser.css.CSSHighlighter;
    
    public class ApplicationCSS extends Sprite
    {
        private var textField:TextField = new TextField();
        
        public function ApplicationCSS()
        {
            var request:URLRequest = new URLRequest("http://blog.yoz.sk/wp-content/themes/dark/style.css");
            var loader:URLLoader = new URLLoader;
            loader.load(request);
            loader.addEventListener(Event.COMPLETE, onComplete);
            
            textField.width = stage.stageWidth;
            textField.height = stage.stageHeight;
            textField.wordWrap = true;
            textField.multiline = true;
            textField.defaultTextFormat = new TextFormat(null, 13);
            addChild(textField);
        }
        
        private function onComplete(event:Event):void
        {
            
            var d0:Date = new Date;
            var highlighter:CSSHighlighter = new CSSHighlighter;
            var source:String = URLLoader(event.currentTarget).data as String;
            var html:String = highlighter.highlight(source);
            var time:Number = new Date().time - d0.time;
            var stat:String = "length: " + Math.round(source.length / 1024) + "Kb, "
                + "time:" + time.toString() + "ms, "
                + "speed: " + Math.round((source.length / 1024) / (time / 1000)) + "Kbps\n";
            
            textField.htmlText = stat + html;
        }
    }
}