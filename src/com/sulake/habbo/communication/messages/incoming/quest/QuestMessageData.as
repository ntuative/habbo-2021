package com.sulake.habbo.communication.messages.incoming.quest
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

        public class QuestMessageData 
    {

        private var _campaignCode:String;
        private var _completedQuestsInCampaign:int;
        private var _questCountInCampaign:int;
        private var _activityPointType:int;
        private var _id:int;
        private var _accepted:Boolean;
        private var _type:String;
        private var _imageVersion:String;
        private var _rewardCurrencyAmount:int;
        private var _localizationCode:String;
        private var _completedSteps:int;
        private var _totalSteps:int;
        private var _SafeStr_1817:int;
        private var _sortOrder:int;
        private var _catalogPageName:String;
        private var _chainCode:String;
        private var _easy:Boolean;
        private var _receiveTime:Date = new Date();

        public function QuestMessageData(_arg_1:IMessageDataWrapper)
        {
            _campaignCode = _arg_1.readString();
            _completedQuestsInCampaign = _arg_1.readInteger();
            _questCountInCampaign = _arg_1.readInteger();
            _activityPointType = _arg_1.readInteger();
            _id = _arg_1.readInteger();
            _accepted = _arg_1.readBoolean();
            _type = _arg_1.readString();
            _imageVersion = _arg_1.readString();
            _rewardCurrencyAmount = _arg_1.readInteger();
            _localizationCode = _arg_1.readString();
            _completedSteps = _arg_1.readInteger();
            _totalSteps = _arg_1.readInteger();
            _sortOrder = _arg_1.readInteger();
            _catalogPageName = _arg_1.readString();
            _chainCode = _arg_1.readString();
            _easy = _arg_1.readBoolean();
        }

        public static function getCampaignLocalizationKeyForCode(_arg_1:String):String
        {
            return ("quests." + _arg_1);
        }


        public function get campaignCode():String
        {
            return (_campaignCode);
        }

        public function get localizationCode():String
        {
            return (_localizationCode);
        }

        public function get completedQuestsInCampaign():int
        {
            return (_completedQuestsInCampaign);
        }

        public function get questCountInCampaign():int
        {
            return (_questCountInCampaign);
        }

        public function get activityPointType():int
        {
            return (_activityPointType);
        }

        public function get accepted():Boolean
        {
            return (_accepted);
        }

        public function get id():int
        {
            return (_id);
        }

        public function get type():String
        {
            return (_type);
        }

        public function get imageVersion():String
        {
            return (_imageVersion);
        }

        public function get rewardCurrencyAmount():int
        {
            return (_rewardCurrencyAmount);
        }

        public function get completedSteps():int
        {
            return (_completedSteps);
        }

        public function get totalSteps():int
        {
            return (_totalSteps);
        }

        public function get isCompleted():Boolean
        {
            return (_completedSteps == _totalSteps);
        }

        public function get waitPeriodSeconds():int
        {
            if (_SafeStr_1817 < 1)
            {
                return (0);
            };
            var _local_1:Date = new Date();
            var _local_2:int = (_local_1.getTime() - _receiveTime.getTime());
            return (int(Math.max(0, (_SafeStr_1817 - Math.floor((_local_2 / 1000))))));
        }

        public function getCampaignLocalizationKey():String
        {
            return (getCampaignLocalizationKeyForCode(campaignCode));
        }

        public function getQuestLocalizationKey():String
        {
            return ((this.getCampaignLocalizationKey() + ".") + _localizationCode);
        }

        public function get completedCampaign():Boolean
        {
            return (_id < 1);
        }

        public function set id(_arg_1:int):void
        {
            _id = _arg_1;
        }

        public function set accepted(_arg_1:Boolean):void
        {
            _accepted = _arg_1;
        }

        public function get lastQuestInCampaign():Boolean
        {
            return (_completedQuestsInCampaign >= _questCountInCampaign);
        }

        public function get receiveTime():Date
        {
            return (_receiveTime);
        }

        public function set waitPeriodSeconds(_arg_1:int):void
        {
            _SafeStr_1817 = _arg_1;
        }

        public function get sortOrder():int
        {
            return (_sortOrder);
        }

        public function get catalogPageName():String
        {
            return (_catalogPageName);
        }

        public function get chainCode():String
        {
            return (_chainCode);
        }

        public function get easy():Boolean
        {
            return (_easy);
        }


    }
}

