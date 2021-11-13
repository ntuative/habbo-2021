package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PatternMatchData implements IDisposable 
    {

        private var _pattern:String;
        private var _startIndex:int;
        private var _endIndex:int;
        private var _disposed:Boolean = false;

        public function PatternMatchData(_arg_1:IMessageDataWrapper)
        {
            _pattern = _arg_1.readString();
            _startIndex = _arg_1.readInteger();
            _endIndex = _arg_1.readInteger();
        }

        public function dispose():void
        {
            _disposed = true;
            _pattern = "";
            _startIndex = -1;
            _endIndex = -1;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function get pattern():String
        {
            return (_pattern);
        }

        public function get startIndex():int
        {
            return (_startIndex);
        }

        public function get endIndex():int
        {
            return (_endIndex);
        }


    }
}