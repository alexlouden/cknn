module.exports = (grunt) ->
  grunt.initConfig
  
    pkg: grunt.file.readJSON("package.json")
    
    # HAML -> HTML
    haml:
      dist:
        src: 'src/index.haml'
        dest: 'dist/index.html'
        options:
          style: 'expanded'

    # Vendor JS
    copy:
      js:
        files:
          [
            {expand: true, cwd: 'src/js/', src: ['*.js'], dest: 'dist/js/', filter: 'isFile'}
          ]

    # Coffee -> JS
    coffee:
      dist:
        expand: true
        cwd: "src/"
        src: ["**/*.coffee"]
        dest: "dist/"
        ext: ".js"
      
        options:
          sourceMap: true

    # SASS -> CSS
    compass:
      dist:
        options:
          sassDir: "src/css"
          cssDir: "dist/css"
          raw: 'preferred_syntax = :sass\n'
        debugsass: true

    # Server
    connect:
      dist:
        options:
          port: 3000,
          base: 'dist/'

    # Watch
    watch:
      livereload:
        files: ["dist/**/*", "dist/*"]
        options:
          livereload: true

      html: 
        files: ["src/**/*.haml"]
        tasks: ["haml"]

      coffee:
        files: ["src/**/*.coffee", "src/**/*.js"]
        tasks: ["coffee"]

      js:
        files: ["src/**/*.js"]
        tasks: ["copy:js"]

      sass: 
        files: ["src/**/*.sass"]
        tasks: ["compass"]

  grunt.loadNpmTasks "grunt-contrib-haml"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-compass"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-watch"

  grunt.registerTask "default", [
    "haml"
    "coffee",
    "copy",
    "compass",
    "connect",
    "watch"
  ]
