package com.sulake.habbo.roomevents.userdefinedroomevents.actiontypes
{
    import com.sulake.habbo.roomevents.userdefinedroomevents.DefaultElement;

    public class DefaultActionType extends DefaultElement implements ActionType 
    {


        public function get allowDelaying():Boolean
        {
            return (true);
        }


    }
}