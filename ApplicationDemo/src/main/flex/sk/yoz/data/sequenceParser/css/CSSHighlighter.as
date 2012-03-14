package sk.yoz.data.sequenceParser.css
{
    public class CSSHighlighter
    {
        private var formatted:String = "";
        
        public function highlight(input:String):String
        {
            formatted = "";
            
            var parser:CSSSequenceParser = new CSSSequenceParser;
            parser.suggestSequences(generalCallback, 
                importStart, importEnd,
                selectorMatch,
                definitionStart, definitionEnd,
                attributeCallback, 
                urlStart, urlEnd,
                valueMatch,
                commentStart, commentEnd,
                quoteStart, quoteEnd);
            parser.parse(input);
            
            return formatted;
        }
        
        private function importStart(value:String):void
        {
            value = optimizeForHTMLTextField(value);
            formatted += "<font color='#0000ff'>" + value + "</font>";
        }
        
        private function importEnd(value:String):void
        {
            value = optimizeForHTMLTextField(value);
            formatted += value;
        }
        
        private function definitionStart(value:String):void
        {
            value = optimizeForHTMLTextField(value);
            formatted += "<font color='#aaaaaa'>" + value + "</font>";
        }
        
        private function definitionEnd(value:String):void
        {
            value = optimizeForHTMLTextField(value);
            formatted += "<font color='#aaaaaa'>" + value + "</font>";
        }
        
        private function attributeCallback(value:String):void
        {
            value = optimizeForHTMLTextField(value);
            formatted += "<font color='#0000ff'>" + value + "</font>";
        }
        
        private function urlStart(value:String):void
        {
            value = optimizeForHTMLTextField(value);
            formatted += "<font color='#0000ff'>" + value + "</font><font color='#ff0000'>";
        }
        
        private function urlEnd(value:String):void
        {
            value = optimizeForHTMLTextField(value);
            formatted += "</font>" + value;
        }
        
        private function commentStart(value:String):void
        {
            value = optimizeForHTMLTextField(value);
            formatted += "<font color='#00ff00'>" + value;
        }
        
        private function commentEnd(value:String):void
        {
            value = optimizeForHTMLTextField(value);
            formatted += value + "</font>";
        }
        
        private function quoteStart(value:String):void
        {
            value = optimizeForHTMLTextField(value);
            formatted += "<font color='#ff00ff'><b>" + value;
        }
        
        private function quoteEnd(value:String):void
        {
            value = optimizeForHTMLTextField(value);
            formatted += value + "</b></font>";
        }
        
        private function selectorMatch(value:String):void
        {
            value = optimizeForHTMLTextField(value);
            formatted += "<b>" + value + "</b>";
        }
        
        private function valueMatch(value:String):void
        {
            value = optimizeForHTMLTextField(value);
            formatted += "<font color='#ff0000'>" + value + "</font>";
        }
        
        private function generalCallback(value:String):void
        {
            value = optimizeForHTMLTextField(value);
            formatted += value;
        }
        
        private function optimizeForHTMLTextField(input:String):String
        {
            return input.replace("\n", "")
                .replace("<", "&lt;").replace(">", "&gt;");;
        }
    }
}