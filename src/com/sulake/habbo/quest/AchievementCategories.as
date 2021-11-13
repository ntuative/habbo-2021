package com.sulake.habbo.quest
{
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;

    public class AchievementCategories 
    {

        private static const ACHIEVEMENT_DISABLED:int = 0;
        private static const ACHIEVEMENT_ENABLED:int = 1;
        private static const ACHIEVEMENT_ARCHIVED:int = 2;
        private static const ACHIEVEMENT_OFF_SEASON:int = 3;
        private static const ACHIEVEMENT_CATEGORY_ARCHIVED:String = "archive";

        private var _SafeStr_3093:Dictionary = new Dictionary();
        private var _categoryList:Vector.<AchievementCategory> = new Vector.<AchievementCategory>(0);

        public function AchievementCategories(_arg_1:Array)
        {
            super();
            var _local_4:AchievementCategory = null;
            var _local_5:AchievementCategory = null;
            var _local_2:AchievementCategory = new AchievementCategory("archive");
            _SafeStr_3093["archive"] = _local_2;
            for each (var _local_3:AchievementData in _arg_1)
            {
                if (_local_3.category != "")
                {
                    if (_local_3.state == 2)
                    {
                        _local_5 = _SafeStr_3093["archive"];
                    }
                    else
                    {
                        _local_5 = _SafeStr_3093[_local_3.category];
                    };
                    if (_local_5 == null)
                    {
                        _local_5 = new AchievementCategory(_local_3.category);
                        _SafeStr_3093[_local_3.category] = _local_5;
                        if (_local_3.category != "misc")
                        {
                            _categoryList.push(_local_5);
                        }
                        else
                        {
                            _local_4 = _local_5;
                        };
                    };
                    _local_5.add(_local_3);
                };
            };
            if (_local_4 != null)
            {
                _categoryList.push(_local_4);
            };
            _categoryList.push(_local_2);
        }

        public function update(_arg_1:AchievementData):void
        {
            if (_arg_1.category == "")
            {
                return;
            };
            var _local_2:AchievementCategory = _SafeStr_3093[_arg_1.category];
            _local_2.update(_arg_1);
        }

        public function get categoryList():Vector.<AchievementCategory>
        {
            return (_categoryList);
        }

        public function getMaxProgress():int
        {
            var _local_1:int;
            for each (var _local_2:AchievementCategory in _categoryList)
            {
                _local_1 = (_local_1 + _local_2.getMaxProgress());
            };
            return (_local_1);
        }

        public function getProgress():int
        {
            var _local_1:int;
            for each (var _local_2:AchievementCategory in _categoryList)
            {
                _local_1 = (_local_1 + _local_2.getProgress());
            };
            return (_local_1);
        }

        public function getCategoryByCode(_arg_1:String):AchievementCategory
        {
            for each (var _local_2:AchievementCategory in _categoryList)
            {
                if (_local_2.code == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }


    }
}

