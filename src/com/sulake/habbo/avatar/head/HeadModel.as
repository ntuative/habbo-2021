package com.sulake.habbo.avatar.head
{
    import com.sulake.habbo.avatar.common.CategoryBaseModel;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.habbo.avatar.HabboAvatarEditor;

    public class HeadModel extends CategoryBaseModel implements IAvatarEditorCategoryModel 
    {

        public function HeadModel(_arg_1:HabboAvatarEditor)
        {
            super(_arg_1);
        }

        override protected function init():void
        {
            super.init();
            initCategory("hr");
            initCategory("ha");
            initCategory("he");
            initCategory("ea");
            initCategory("fa");
            _SafeStr_573 = true;
            if (!_SafeStr_570)
            {
                _SafeStr_570 = new HeadView(this);
                if (_SafeStr_570)
                {
                    _SafeStr_570.init();
                };
            };
        }


    }
}

