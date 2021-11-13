package com.sulake.habbo.help.guidehelp
{
    public class GuideSessionData 
    {

        public static const ROLE_UNDECIDED:uint = 0;
        public static const ROLE_GUIDE:uint = 1;
        public static const ROLE_USER:uint = 2;
        public static const _SafeStr_2673:int = 0;
        public static const _SafeStr_2674:int = 1;
        public static const _SafeStr_2675:int = 2;

        private var _SafeStr_2676:uint = 0;
        private var _activeWindow:String = "";
        private var _requestType:uint = 0;
        private var _requestDescription:String = "";
        private var _userId:uint = 0;
        private var _userName:String = "";
        private var _userFigure:String = "";
        private var _guideId:uint = 0;
        private var _guideName:String = "";
        private var _guideFigure:String = "";


        public function isActiveSession():Boolean
        {
            return ((isActiveUserSession()) || (isActiveGuideSession()));
        }

        public function isActiveUserSession():Boolean
        {
            return ((_SafeStr_2676 == 2) && ((((_activeWindow == "user_create") || (_activeWindow == "user_pending")) || (_activeWindow == "user_ongoing")) || (_activeWindow == "user_feedback")));
        }

        public function isActiveGuideSession():Boolean
        {
            return ((_SafeStr_2676 == 1) && (((_activeWindow == "guide_accept") || (_activeWindow == "guide_ongoing")) || (_activeWindow == "guide_closed")));
        }

        public function isOnGoingSession():Boolean
        {
            return ((_activeWindow == "guide_ongoing") || (_activeWindow == "user_ongoing"));
        }

        public function set role(_arg_1:uint):void
        {
            _SafeStr_2676 = _arg_1;
        }

        public function get activeWindow():String
        {
            return (_activeWindow);
        }

        public function set activeWindow(_arg_1:String):void
        {
            _activeWindow = _arg_1;
        }

        public function get requestType():uint
        {
            return (_requestType);
        }

        public function set requestType(_arg_1:uint):void
        {
            _requestType = _arg_1;
        }

        public function get requestDescription():String
        {
            return (_requestDescription);
        }

        public function set requestDescription(_arg_1:String):void
        {
            _requestDescription = _arg_1;
        }

        public function get userId():uint
        {
            return (_userId);
        }

        public function set userId(_arg_1:uint):void
        {
            _userId = _arg_1;
        }

        public function get userName():String
        {
            return (_userName);
        }

        public function set userName(_arg_1:String):void
        {
            _userName = _arg_1;
        }

        public function get userFigure():String
        {
            return (_userFigure);
        }

        public function set userFigure(_arg_1:String):void
        {
            _userFigure = _arg_1;
        }

        public function get guideId():uint
        {
            return (_guideId);
        }

        public function set guideId(_arg_1:uint):void
        {
            _guideId = _arg_1;
        }

        public function get guideName():String
        {
            return (_guideName);
        }

        public function set guideName(_arg_1:String):void
        {
            _guideName = _arg_1;
        }

        public function get guideFigure():String
        {
            return (_guideFigure);
        }

        public function set guideFigure(_arg_1:String):void
        {
            _guideFigure = _arg_1;
        }


    }
}

