package deng.fzip
{
    import flash.events.Event;

    public class FZipErrorEvent extends Event 
    {

        public static const PARSE_ERROR:String = "parseError";

        public var text:String;

        public function FZipErrorEvent(_arg_1:String, _arg_2:String="", _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            this.text = _arg_2;
            super(_arg_1, _arg_3, _arg_4);
        }

        override public function clone():Event
        {
            return (new FZipErrorEvent(type, text, bubbles, cancelable));
        }


    }
}