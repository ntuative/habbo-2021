package com.sulake.habbo.communication.messages.parser.moderation
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class ModeratorToolPreferencesMessageParser implements IMessageParser 
    {

        private var _windowX:int;
        private var _windowY:int;
        private var _windowWidth:int;
        private var _windowHeight:int;


        public function get windowX():int
        {
            return (_windowX);
        }

        public function get windowY():int
        {
            return (_windowY);
        }

        public function get windowWidth():int
        {
            return (_windowWidth);
        }

        public function get windowHeight():int
        {
            return (_windowHeight);
        }

        public function flush():Boolean
        {
            _windowX = 0;
            _windowY = 0;
            _windowWidth = 0;
            _windowHeight = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _windowX = _arg_1.readInteger();
            _windowY = _arg_1.readInteger();
            _windowWidth = _arg_1.readInteger();
            _windowHeight = _arg_1.readInteger();
            return (true);
        }


    }
}