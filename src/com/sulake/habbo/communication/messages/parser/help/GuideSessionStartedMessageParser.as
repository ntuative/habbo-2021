package com.sulake.habbo.communication.messages.parser.help
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GuideSessionStartedMessageParser implements IMessageParser 
    {

        private var _requesterUserId:int;
        private var _requesterName:String;
        private var _requesterFigure:String;
        private var _guideUserId:int;
        private var _guideName:String;
        private var _guideFigure:String;


        public function flush():Boolean
        {
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _requesterUserId = _arg_1.readInteger();
            _requesterName = _arg_1.readString();
            _requesterFigure = _arg_1.readString();
            _guideUserId = _arg_1.readInteger();
            _guideName = _arg_1.readString();
            _guideFigure = _arg_1.readString();
            return (true);
        }

        public function get requesterUserId():int
        {
            return (_requesterUserId);
        }

        public function get requesterName():String
        {
            return (_requesterName);
        }

        public function get requesterFigure():String
        {
            return (_requesterFigure);
        }

        public function get guideUserId():int
        {
            return (_guideUserId);
        }

        public function get guideName():String
        {
            return (_guideName);
        }

        public function get guideFigure():String
        {
            return (_guideFigure);
        }


    }
}