package com.sulake.habbo.avatar.legs
{
    import com.sulake.habbo.avatar.common.CategoryBaseModel;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.habbo.avatar.HabboAvatarEditor;

    public class LegsModel extends CategoryBaseModel implements IAvatarEditorCategoryModel 
    {

        public function LegsModel(_arg_1:HabboAvatarEditor)
        {
            super(_arg_1);
        }

        override protected function init():void
        {
            super.init();
            initCategory("lg");
            initCategory("sh");
            initCategory("wa");
            _SafeStr_573 = true;
            if (!_SafeStr_570)
            {
                _SafeStr_570 = new LegsView(this);
                if (_SafeStr_570)
                {
                    _SafeStr_570.init();
                };
            };
        }


    }
}

