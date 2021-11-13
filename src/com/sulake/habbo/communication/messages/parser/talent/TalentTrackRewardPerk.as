package com.sulake.habbo.communication.messages.parser.talent
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class TalentTrackRewardPerk 
    {

        private var _perkId:String;

        public function TalentTrackRewardPerk(_arg_1:IMessageDataWrapper)
        {
            _perkId = _arg_1.readString();
        }

        public function get perkId():String
        {
            return (_perkId);
        }


    }
}