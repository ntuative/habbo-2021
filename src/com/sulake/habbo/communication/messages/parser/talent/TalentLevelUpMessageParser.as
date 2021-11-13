package com.sulake.habbo.communication.messages.parser.talent
{
    import com.sulake.core.communication.messages.IMessageParser;
    import __AS3__.vec.Vector;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class TalentLevelUpMessageParser implements IMessageParser 
    {

        private var _talentTrackName:String;
        private var _level:int;
        private var _rewardPerks:Vector.<TalentTrackRewardPerk>;
        private var _rewardProducts:Vector.<TalentTrackRewardProduct>;


        public function flush():Boolean
        {
            _talentTrackName = null;
            _rewardPerks = null;
            _rewardProducts = null;
            return (true);
        }

        public function parse(_arg_1:IMessageDataWrapper):Boolean
        {
            var _local_3:int;
            _talentTrackName = _arg_1.readString();
            _level = _arg_1.readInteger();
            _rewardPerks = new Vector.<TalentTrackRewardPerk>();
            var _local_4:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_4)
            {
                _rewardPerks.push(new TalentTrackRewardPerk(_arg_1));
                _local_3++;
            };
            _rewardProducts = new Vector.<TalentTrackRewardProduct>();
            var _local_2:int = _arg_1.readInteger();
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                _rewardProducts.push(new TalentTrackRewardProduct(_arg_1));
                _local_3++;
            };
            return (true);
        }

        public function get talentTrackName():String
        {
            return (_talentTrackName);
        }

        public function get level():int
        {
            return (_level);
        }

        public function get rewardPerks():Vector.<TalentTrackRewardPerk>
        {
            return (_rewardPerks);
        }

        public function get rewardProducts():Vector.<TalentTrackRewardProduct>
        {
            return (_rewardProducts);
        }


    }
}