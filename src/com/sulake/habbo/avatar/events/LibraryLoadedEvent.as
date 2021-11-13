package com.sulake.habbo.avatar.events
{
    import flash.events.Event;

    public class LibraryLoadedEvent extends Event 
    {

        private var _library:String;

        public function LibraryLoadedEvent(_arg_1:String, _arg_2:String)
        {
            super(_arg_1);
            this._library = _arg_2;
        }

        public function get library():String
        {
            return (_library);
        }


    }
}