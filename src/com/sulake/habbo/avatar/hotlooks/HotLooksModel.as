package com.sulake.habbo.avatar.hotlooks
{
    import com.sulake.habbo.avatar.common.CategoryBaseModel;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import flash.utils.Dictionary;
    import com.sulake.habbo.communication.messages.incoming.hotlooks.HotLooksMessageEvent;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.habbo.communication.messages.outgoing.hotlooks.GetHotLooksMessageComposer;
    import com.sulake.habbo.communication.messages.incoming.hotlooks.HotLookInfo;
    import com.sulake.habbo.avatar.wardrobe.Outfit;
    import com.sulake.habbo.avatar.common.CategoryData;
    import com.sulake.habbo.avatar.wardrobe.*;

    public class HotLooksModel extends CategoryBaseModel implements IAvatarEditorCategoryModel 
    {

        public static const CATEGORY_HOT_LOOKS:String = "hot_looks";
        public static const CATEGORY_MY_LOOKS:String = "my_looks";
        private static const MAXIMUM_HOT_LOOKS:int = 20;

        private var _SafeStr_1334:Dictionary;
        private var _SafeStr_1335:HotLooksMessageEvent;

        public function HotLooksModel(_arg_1:HabboAvatarEditor)
        {
            super(_arg_1);
            _SafeStr_1334 = new Dictionary();
            _SafeStr_1334["M"] = [];
            _SafeStr_1334["F"] = [];
            _SafeStr_1334["M.index"] = 0;
            _SafeStr_1334["F.index"] = 0;
            requestHotLooks(_arg_1);
        }

        private function requestHotLooks(_arg_1:HabboAvatarEditor):void
        {
            _SafeStr_1335 = new HotLooksMessageEvent(onHotLooksMessage);
            _arg_1.manager.communication.addHabboConnectionMessageEvent(_SafeStr_1335);
            _arg_1.manager.communication.connection.send(new GetHotLooksMessageComposer(20));
        }

        private function onHotLooksMessage(_arg_1:HotLooksMessageEvent):void
        {
            for each (var _local_2:HotLookInfo in _arg_1.getParser().hotLooks)
            {
                (_SafeStr_1334[_local_2.gender.toUpperCase()] as Array).push(new Outfit(_SafeStr_1284, _local_2.figureString, _local_2.gender));
            };
        }

        override public function dispose():void
        {
            super.dispose();
            if (_SafeStr_1335)
            {
                controller.manager.communication.removeHabboConnectionMessageEvent(_SafeStr_1335);
                _SafeStr_1335 = null;
            };
            _SafeStr_1334 = null;
        }

        override protected function init():void
        {
            if (!_SafeStr_570)
            {
                _SafeStr_570 = new HotLooksView(this);
            };
            _SafeStr_570.init();
            _SafeStr_573 = true;
        }

        public function selectHotLook(_arg_1:int):void
        {
            var _local_2:Array = _SafeStr_1334[_SafeStr_1284.gender];
            var _local_3:Outfit = _local_2[_arg_1];
            if (_local_3 != null)
            {
                if (_local_3.figure == "")
                {
                    return;
                };
                _SafeStr_1284.loadAvatarInEditor(_local_3.figure, _local_3.gender, _SafeStr_1284.clubMemberLevel);
            };
        }

        public function get hotLooks():Array
        {
            return (_SafeStr_1334[_SafeStr_1284.gender]);
        }

        override public function switchCategory(_arg_1:String=""):void
        {
        }

        override public function getCategoryData(_arg_1:String):CategoryData
        {
            return (null);
        }

        override public function selectPart(_arg_1:String, _arg_2:int):void
        {
        }


    }
}

