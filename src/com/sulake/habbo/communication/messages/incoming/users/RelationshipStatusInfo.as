package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class RelationshipStatusInfo 
    {

        private var _relationshipStatusType:int;
        private var _friendCount:int;
        private var _randomFriendId:int;
        private var _randomFriendName:String;
        private var _randomFriendFigure:String;

        public function RelationshipStatusInfo(_arg_1:IMessageDataWrapper)
        {
            _relationshipStatusType = _arg_1.readInteger();
            _friendCount = _arg_1.readInteger();
            _randomFriendId = _arg_1.readInteger();
            _randomFriendName = _arg_1.readString();
            _randomFriendFigure = _arg_1.readString();
        }

        public function get relationshipStatusType():int
        {
            return (_relationshipStatusType);
        }

        public function get friendCount():int
        {
            return (_friendCount);
        }

        public function get randomFriendId():int
        {
            return (_randomFriendId);
        }

        public function get randomFriendName():String
        {
            return (_randomFriendName);
        }

        public function get randomFriendFigure():String
        {
            return (_randomFriendFigure);
        }


    }
}