package sk.yoz.data.sequenceParser.css
{
    import sk.yoz.data.sequenceParser.SequenceParser;
    import sk.yoz.data.sequenceParser.sequences.ISequence;
    import sk.yoz.data.sequenceParser.sequences.MatchAnythingSequence;
    import sk.yoz.data.sequenceParser.sequences.MatchRegexpSequence;
    import sk.yoz.data.sequenceParser.sequences.StartRegexpEndStringSequence;
    import sk.yoz.data.sequenceParser.sequences.StartStringEndStringSequence;

    public class CSSSequenceParser
    {
        private var sequences:Vector.<ISequence> = new Vector.<ISequence>;
        
        public function suggestSequences(generalCallback:Function, 
                                         importStart:Function, importEnd:Function,
                                         selectorMatch:Function,
                                         definitionStart:Function, definitionEnd:Function,
                                         attributeCallback:Function,
                                         urlStart:Function, urlEnd:Function,
                                         valueMatch:Function, 
                                         commentStart:Function, commentEnd:Function,
                                         quoteStart:Function, quoteEnd:Function):void
        {
            var definitionSequences:Vector.<ISequence> = new Vector.<ISequence>;
            var importSequences:Vector.<ISequence> = new Vector.<ISequence>;
            var urlSequences:Vector.<ISequence> = new Vector.<ISequence>;
            var commentSequences:Vector.<ISequence> = new Vector.<ISequence>;
            var quoteSequences:Vector.<ISequence> = new Vector.<ISequence>;
            
            var sequenceAny:ISequence = new MatchAnythingSequence(false, generalCallback);
            var sequenceSpaces:ISequence = new MatchRegexpSequence(/^[\s]+/, false, generalCallback);
            var sequenceSelector:ISequence = new MatchRegexpSequence(/^[^\,\{\/]+/i, false, selectorMatch);
            var sequenceDefinition:ISequence = new StartStringEndStringSequence("{", "}", 
                definitionSequences, false, definitionStart, definitionEnd);
            var sequenceAttribute:ISequence = new MatchRegexpSequence(/^[a-z\-]+[\s]*(?:\:)/i, false, attributeCallback);
            var sequenceValue:ISequence = new MatchRegexpSequence(/^[^\:\;\s\}]+/, false, valueMatch);
            var sequenceImport:ISequence = new StartRegexpEndStringSequence(/^\@import/i, ";", 
                importSequences, false, importStart, importEnd);
            var sequenceURL:ISequence = new StartRegexpEndStringSequence(/^url\(/i, ")", 
                urlSequences, false, urlStart, urlEnd);
            var sequenceComment:ISequence = new StartStringEndStringSequence("/*", "*/", 
                commentSequences, false, commentStart, commentEnd);
            var sequenceQuote:ISequence = new StartStringEndStringSequence('"', '"', 
                quoteSequences, false, quoteStart, quoteEnd);
            var sequenceQuote2:ISequence = new StartStringEndStringSequence("'", "'", 
                quoteSequences, false, quoteStart, quoteEnd);
            
            definitionSequences.push(sequenceComment);
            definitionSequences.push(sequenceAttribute);
            definitionSequences.push(sequenceURL);
            definitionSequences.push(sequenceQuote);
            definitionSequences.push(sequenceQuote2);
            definitionSequences.push(sequenceValue);
            definitionSequences.push(sequenceSpaces);
            definitionSequences.push(sequenceAny);
            
            importSequences.push(sequenceComment);
            importSequences.push(sequenceURL);
            importSequences.push(sequenceQuote);
            importSequences.push(sequenceQuote2);
            importSequences.push(sequenceAny);
            
            urlSequences.push(sequenceComment);
            urlSequences.push(sequenceQuote);
            urlSequences.push(sequenceQuote2);
            urlSequences.push(sequenceSpaces);
            urlSequences.push(sequenceAny);
            
            commentSequences.push(sequenceAny);
            
            quoteSequences.push(sequenceAny);
            
            sequences = new Vector.<ISequence>;
            sequences.push(sequenceComment);
            sequences.push(sequenceImport);
            sequences.push(sequenceSelector);
            sequences.push(sequenceDefinition);
            sequences.push(sequenceSpaces);
            sequences.push(sequenceAny);
        }
        
        public function parse(input:String):String
        {
            return SequenceParser.parse(input, sequences);
        }
    }
}