package com.sulake.habbo.communication.messages.parser.users
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.users.MemberData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class GroupMembershipRequestedMessageParser implements IMessageParser 
    {

        private var _groupId:int;
        private var _requester:MemberData;


        public function flush():Boolean
        {
            _requester = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _groupId = _arg_1.readInteger();
            _requester = new MemberData(_arg_1);
            return (true);
        }

        public function get groupId():int
        {
            return (_groupId);
        }

        public function get requester():MemberData
        {
            return (_requester);
        }


    }
}