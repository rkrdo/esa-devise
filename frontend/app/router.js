import Ember from 'ember';

var Router = Ember.Router.extend({
  location: NotesENV.locationType
});

Router.map(function() {
  this.route('application');
  this.route('login');
  this.route('protected');
  this.resource('users');
});

export default Router;
