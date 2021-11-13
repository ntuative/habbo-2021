package deng.fzip
{
    import flash.events.Event;

    public class FZipEvent extends Event 
    {

        public static const FILE_LOADED:String = "fileLoaded";

        public var file:FZipFile;

        public function FZipEvent(_arg_1:String, _arg_2:FZipFile=null, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            this.file = _arg_2;
            super(_arg_1, _arg_3, _arg_4);
        }

        override public function clone():Event
        {
            return (new FZipEvent(type, file, bubbles, cancelable));
        }

        override public function toString():String
        {
            return (((((((((('[FZipEvent type="' + type) + '" filename="') + file.filename) + '" bubbles=') + bubbles) + " cancelable=") + cancelable) + " eventPhase=") + eventPhase) + "]");
        }


    }
}