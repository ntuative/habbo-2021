package com.sulake.habbo.communication.messages.parser.help.data
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class PendingGuideTicket 
    {

        private var _type:int;
        private var _secondsAgo:int;
        private var _isGuide:Boolean;
        private var _otherPartyName:String;
        private var _otherPartyFigure:String;
        private var _description:String;
        private var _roomName:String;

        public function PendingGuideTicket(_arg_1:IMessageDataWrapper):void
        {
            _type = _arg_1.readInteger();
            _secondsAgo = _arg_1.readInteger();
            _isGuide = _arg_1.readBoolean();
            switch (_type)
            {
                case 0:
                case 2:
                    _otherPartyName = _arg_1.readString();
                    _otherPartyFigure = _arg_1.readString();
                    return;
                case 3:
                    if (!isGuide)
                    {
                        _otherPartyName = _arg_1.readString();
                        _otherPartyFigure = _arg_1.readString();
                        _roomName = _arg_1.readString();
                    };
                    return;
                case 1:
                    _otherPartyName = _arg_1.readString();
                    _otherPartyFigure = _arg_1.readString();
                    _description = _arg_1.readString();
                    return;
                default:
                    return;
            };
        }

        public function get type():int
        {
            return (_type);
        }

        public function get secondsAgo():int
        {
            return (_secondsAgo);
        }

        public function get isGuide():Boolean
        {
            return (_isGuide);
        }

        public function get otherPartyName():String
        {
            return (_otherPartyName);
        }

        public function get otherPartyFigure():String
        {
            return (_otherPartyFigure);
        }

        public function get description():String
        {
            return (_description);
        }

        public function get roomName():String
        {
            return (_roomName);
        }


    }
}