package com.sulake.habbo.communication.messages.parser.newnavigator
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class NewNavigatorPreferencesParser implements IMessageParser 
    {

        private var _windowX:int;
        private var _windowY:int;
        private var _windowWidth:int;
        private var _windowHeight:int;
        private var _leftPaneHidden:Boolean;
        private var _resultsMode:int;


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

        public function get leftPaneHidden():Boolean
        {
            return (_leftPaneHidden);
        }

        public function get resultsMode():int
        {
            return (_resultsMode);
        }

        public function flush():Boolean
        {
            _windowX = 0;
            _windowY = 0;
            _windowWidth = 0;
            _windowHeight = 0;
            _leftPaneHidden = false;
            _resultsMode = 0;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _windowX = _arg_1.readInteger();
            _windowY = _arg_1.readInteger();
            _windowWidth = _arg_1.readInteger();
            _windowHeight = _arg_1.readInteger();
            _leftPaneHidden = _arg_1.readBoolean();
            _resultsMode = _arg_1.readInteger();
            return (true);
        }


    }
}