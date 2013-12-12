module.exports = (grunt) ->
  
  sourceOrigin = 'src/**/*.coffee'
  
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    clean:
      dist: ['dist']
    amd_tamer:
      combine:
        options:
          base: 'src/'
          namespace: '<%= pkg.name %>'
        files:
          'dist/<%= pkg.name %>.coffee': 'src/**/*.coffee'
    coffeelint:
      source: ['src/**/*.coffee']
    coffee:
      compile:
        files:
          'dist/<%= pkg.name %>.js': ['udefine/*.coffee', 'src/**/*.coffee']
    uglify:
      options:
        banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today("dd-mm-yyyy") %> */\n'
        report: 'gzip'
      dist:
        files:
          'dist/<%= pkg.name %>.min.js': 'dist/<%= pkg.name %>.js'
        

  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)
  
  grunt.registerTask 'test', 'Lints and unit tests', ['coffeelint']
  grunt.registerTask 'default', 'Default task', ['clean', 'amd_tamer', 'coffee', 'test', 'uglify']