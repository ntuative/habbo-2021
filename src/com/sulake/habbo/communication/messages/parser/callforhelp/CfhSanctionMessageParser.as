package com.sulake.habbo.communication.messages.parser.callforhelp
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.callforhelp.CfhSanctionTypeData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class CfhSanctionMessageParser implements IMessageParser 
    {

        private var _issueId:int = -1;
        private var _accountId:int = -1;
        private var _sanctionType:CfhSanctionTypeData;


        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            _issueId = _arg_1.readInteger();
            _accountId = _arg_1.readInteger();
            _sanctionType = new CfhSanctionTypeData(_arg_1);
            return (true);
        }

        public function get issueId():int
        {
            return (_issueId);
        }

        public function get accountId():int
        {
            return (_accountId);
        }

        public function get sanctionType():CfhSanctionTypeData
        {
            return (_sanctionType);
        }

        public function flush():Boolean
        {
            _issueId = -1;
            _accountId = -1;
            _sanctionType = null;
            return (true);
        }


    }
}