# Sonatype Nexus

[Official](https://www.sonatype.com/products/sonatype-nexus-oss-download#main-content)

## Content

[Documentation](#documentation)

[Analogs](#analogs)

[Run in docker](#run-in-docker)

[Docker compose](#docker-compose)

[Comands](#comands)

[Repository vs. Repository Manager](#repository-vs-repository-manager)

[Repository Types](#repository-types)

[Creating and Managing Users](#creating-and-managing-users)

[Managing Maven Proxy and Hosted Repositories](#managing-maven-proxy-and-hosted-repositories)

## Documentation

[official](https://help.sonatype.com/repomanager3)

[videos](https://my.sonatype.com/videos/install-and-configure-nexus-repository)

[learn](https://learn.sonatype.com/courses/nxrm-config-100/)

[Nexus Repository Manager Support]( https://support.sonatype.com/hc/en-us/categories/202673428-Nexus-Repository-Manager-3)

[Product Information](https://www.sonatype.com/nexus-repository-sonatype)

[Sonatype Community](https://community.sonatype.com/c/nexus-repository)


## Analogs

https://launchpad.net/

https://build.opensuse.org/


[Content](#content)

## Run in docker


### Nexus

https://hub.docker.com/r/sonatype/nexus

`docker run -d -p 8081:8081 --name nexus sonatype/nexus:oss`

`curl http://localhost:8081/nexus/service/local/status`

`docker logs -f nexus`

`docker run -d -p 8081:8081 --name nexus -e MAX_HEAP=768m sonatype/nexus`

#### Use a docker volume

`docker volume create my-vol`

`docker run -d --name nexus-data sonatype/nexus echo "data-only container for Nexus"`

`docker run -d -p 8081:8081 --name nexus --volumes-from nexus-data sonatype/nexus`

`docker run -d -p 8081:8081 --name nexus sonatype/nexus`

#### Mount a host directory as the volume

`mkdir /some/dir/nexus-data && chown -R 200 /some/dir/nexus-data`

`docker run -d -p 8081:8081 --name nexus -v /some/dir/nexus-data:/sonatype-work sonatype/nexus`



### Nexus 3

https://hub.docker.com/r/sonatype/nexus3


`docker run -d -p 8081:8081 --name nexus sonatype/nexus3`

`curl http://localhost:8081/`

`docker logs -f nexus`

`docker run -d -p 8081:8081 --name nexus -e INSTALL4J_ADD_VM_PARAMS="-Xms2703m -Xmx2703m -XX:MaxDirectMemorySize=2703m -Djava.util.prefs.userRoot=/some-other-dir" sonatype/nexus3`

#### Use a docker volume

`docker volume create --name nexus-data`

`docker run -d -p 8081:8081 --name nexus -v nexus-data:/opt/sonatype/sonatype-work/nexus3 sonatype/nexus3`

#### Mount a host directory as the volume

`mkdir /some/dir/nexus-data && chown -R 200 /some/dir/nexus-data`

`docker run -d -p 8081:8081 --name nexus -v /some/dir/nexus-data:/opt/sonatype/sonatype-work/nexus3 sonatype/nexus3`

username = admin

password = `cat /opt/sonatype/sonatype-work/nexus3/admin.password`


`docker container exec -it nexus cat /opt/sonatype/sonatype-work/nexus3/admin.password`

[Content](#content)

## Docker compose

```yaml
version: "3.8"
services:
  nexus:
    image: sonatype/nexus3
    volumes:
      - ./data:/opt/sonatype/sonatype-work/nexus3
    ports:
      - 8081:8081
      - 8085:8085
```


Make sure permissions

`mkdir nexus && chown -R 200 nexus`

`sudo chown -R vagrant:vagrant nexus` - if your user vagrant

`chmod -R 777 nexus`  - permission to write to folder data

`mkdir data && chown -R 200 data`

`sudo chown -R vagrant:vagrant data` - if your user vagrant

`chmod -R 777 data`  - permission to write to folder data

[Content](#content)

## Install

create directory

```txt
install_dir
|
|-nexus_version
|
|-sanatype-work

```
### Linux

reccomendation to use opt

`cd /opt`

`mkdir install_dir`

https://help.sonatype.com/repomanager3/product-information/download

`wget https://download.sonatype.com/nexus/3/nexus-3.60.0-02-unix.tar.gz`

`cd /opt`

`sudo mkdir nexus`

`sudo wget https://download.sonatype.com/nexus/3/nexus-3.60.0-02-unix.tar.gz`

`sudo tar xf nexus-3.60.0-02-unix.tar.gz`

`cd nexus-3.60.0-02`

`cd bin`

` sudo ./nexus run`

`./nexus run` for *Unix operating systems like Linux

http://localhost:8081/

Make sure your terminal is open to complete the authentication steps.

From the Welcome screen.
Click Sign in. A Sign in pop up box is displayed.
Navigate to …/sonatype-work/nexus3 in your terminal.
Locate the admin.password file.

username `admin`

`sudo cat /opt/sonatype-work/nexus3/admin.password`

Copy the string from the file to the password field, and sign in.
Click Next to start the Setup module.
Enter a new password then enter it again in the Confirm password field.
Click Next.
Decide whether you want to enable anonymous access or not in the Configure Anonymous Access modal.


#### Windows

https://download.sonatype.com/nexus/3/nexus-3.60.0-02-win64.zip

unzip

`nexus.exe /run`  for Windows

http://localhost:8081/


username `admin`

`sonatype-work/nexus3/admin.password`

Copy the string from the file to the password field, and sign in.
Click Next to start the Setup module.
Enter a new password then enter it again in the Confirm password field.
Click Next.
Decide whether you want to enable anonymous access or not in the Configure Anonymous Access modal.

[Content](#content)

### Vagrant docker

`cd basic`

`vagrant up`

http://100.0.0.15:8081

`vagrant ssh basic` - connect to VM

Then steps the same as for [docker](#run-in-docker)

Required 2 CPU 3072Mb RAM

VM username `vagrant`

VM password `vagrant`

### Vagrant

required VM Box

`cd linux_with_nexus`

inside `data` appears file `admin.password`

http://100.0.0.16:8081

login:
username: admin
password: from `admin.password` file

`vagrant up`

`vagrant ssh nexus` - connect to VM

VM username `vagrant`

VM password `vagrant`

## Comands

`mvn -v` check version


[Content](#content)




## Repository vs. Repository Manager

### Repository


A repository is a storage location where components such as packages, libraries, binaries, or containers are retrieved so they can be installed or used (you’ll learn more about components in lesson two). In order to ease consumption and usage of open source components, they are aggregated into collections on public repositories, and are typically available on the internet as a service. Examples of such repositories are:

Central Repository, also known as Maven Central
NuGet Gallery
RubyGems.org
npmjs.org

### Repository Manager

A  repository manager is a dedicated server application used to manage all the repositories your development teams use throughout the course of development. At its core, a repository manager does the following:

Proxies remote repositories and caches contents.
Hosts internal repositories.
Groups repositories into a single repository.
Using these core functions, a repository manager becomes the central and authoritative storage platform for all open source and proprietary items produced by your development team. With a repository manager, you can completely control access to, and deployment of, every component in your organization from a single location. It allows you to control what gets into your products from remote sources as well as examine, and keep track of, what’s produced by your build systems.  A repository manager also allows you to secure a connection to remote repositories, ensuring that your usage is not publicly exposed.


### What are Components

In Nexus Repository Manager, the term component describes items like a package, library, binary, container, or any other resource produced or used by your software application. In different tool-chains, components are called artifacts, packages, bundles, archives and so on. The concept and idea remains the same, and component is used to make the term more broad and encompass multiple languages.

### Supported Formats in Nexus Repository Manager

Most formats have a single, designated central repository maintained on behalf of the community, such as PyPI’s Python Package Index and Bower’s registry. Other formats may have one or more major alternatives. A few formats, such as Yum, do not have a central repository, but have common repositories like CentOS or Red Hat repositories. With Nexus Repository Manager, you can proxy any of these remote repositories and cache components for distribution. 

As of this publication, Nexus Repository Manager supports the following formats:

Bower
Docker
git-lfs
Maven 2
npm
NuGet
PyPI
RubyGems
Raw (Site)
Yum
For the latest updates, refer to Supported Formats in the Nexus Repository Manager help site.

[Content](#content)



## Repository Types


In Nexus Repository Manager there are three repository types—proxy repositories, hosted repositories, and repository groups—all using a number of different repository formats. Understanding the available repository types helps define what is needed within your organization for a successful Repository Manager implementation.

### Proxy Repositories

A proxy repository is a repository that is linked to a remote repository. Any request for a component is verified against the local content of the proxy repository. If no local component is found, the request is forwarded to the remote repository. The component is then retrieved and stored locally in the repository manager, which acts as a cache. Any future requests for the same component are fulfilled from the local storage, eliminating network bandwidth and time overhead when retrieving the component from the remote repository again. In addition, when components are downloaded to the Nexus Repository Manager proxy, a copy remains there indefinitely, unless removed by a Repository Manager administrator. This is extremely useful in the event a component becomes unavailable in the remote repository, and provides more control over the components needed to build your applications.

By default, the repository manager ships with the following configured proxy repositories:

maven-central: This proxy repository accesses the Central Repository, formerly known as Maven Central. It is the default component repository built into Apache Maven and is well-supported by other build tools like Gradle, SBT or Ant/Ivy.
nuget.org-proxy: This proxy repository accesses the NuGet Gallery. It is the default component repository used by the nuget package management tool used for .Net development.
As of this publication, the following proxy repositories are also available for user configuration:

Bower
Docker
npm
PyPI
Raw
RubyGems
Yum


### Hosted Repositories

A hosted repository is a repository that stores components in the repository manager as the authoritative location for these components. For example, create a hosted repository when you have internal components that aren’t downloaded from a public repository, but are used by various development teams in your organization.

By default, the repository manager ships with the following configured hosted repositories:

maven-releases: This hosted repository uses the maven2 repository format with a release version policy. It’s intended to be the repository where your organization publishes internal releases. You can also use this repository for third-party components that aren’t available in external repositories.
maven-snapshots: This hosted repository uses the maven2 repository format with a snapshot version policy. It’s intended to be the repository where your organization publishes internal development versions, also known as snapshots.
nuget-hosted: This hosted repository is where your organization can publish internal releases in repository using the NuGet repository format. You can also use this repository for third-party components that are not available in external repositories that could potentially be proxied to gain access to the components.
As of this publication, the following hosted repositories are also available for user configuration:

Bower
Docker
Git LFS
npm
PyPI
Raw
RubyGems


Snapshot and Release Subtypes
Within the hosted repository type, there is a subtype of release or snapshot for the maven2 format. Similar to the difference between a production environment and a staging environment, we recommend using a release repository for stable components in production and a snapshot repository for components still in the development phase. While there is a higher level of procedure and ceremony associated with deploying to a release repository, snapshot releases can be deployed and changed frequently without regard for stability concerns.

### Group Repositories

A repository group  is a collection of other repositories, where you can combine multiple repositories of the same format into a single item. This represents a powerful feature of Nexus Repository Manager that lets developers rely on a single URL for their configuration needs. For example, if your group has a Maven Central proxy repository and a hosted repository for 3rd party JARs, these can be combined into a group with one URL for builds.

The repository manager ships with the following groups:

maven-public: This is a repository group of maven2 formatted repositories. It combines the external proxy for the Central Repository, along with the hosted repositories maven-releases and maven-snapshots. 
nuget-group: This group combines the NuGet formatted repositories nuget-hosted and nuget.org-proxy into a single repository for your .NET development with NuGet.
As of this publication, the following group repositories are also available for user configuration:

Bower
Docker
npm
PyPI
Raw
RubyGems


[Content](#content)



## Use Case

### Why You Need a Repository Manager

Use Case
The following use case provides an example that highlights the need for a repository manager in your organization. Use this to get an idea of how Nexus Repository Manager can be utilized on your team.

Background
You are part of a small team working to apply a DevOps approach to your organization. The development team is primarily JAVA-focused with heavy Maven and Central Repository usage.

Challenge
Currently, developers are downloading the same components over and over again, slowing down production and decreasing build performance.

Solution
Develop a proof of concept for a repository manager that helps alleviate slow downloads related to open source component usage. Begin thinking of repository configuration specific to your organization.

Results
Centralized management for components means the development team can download all their dependencies from Nexus Repository Manager.
Improved software build performance due to faster component download off the local repository manager.
Reduced bandwidth usage due to component caching.
Higher predictability and scalability due to limited dependency on remote repositories.
Increased understanding of component usage due to centralized storage of all used components.
Simplified developer configuration due to central access configuration to remote repositories and components on the repository manager.
Unified method to provide components to consumers reducing complexity overheads.
Improved collaboration due to the simplified exchange of binary components.



### Repository Manager Planning

Planning requirements needed for successful installation and implementation of Nexus Repository
Manager 3 (NXRM3).
1. How many employees are using NXRM3?
2. How are user accounts managed in your organization?
3. How many installations of NXRM3 are needed?
4. Where will repositories be located?
5. What source control management tools are used in your organization?
6. What build tools are in place?
7. What languages are used in your organization?
8. What package formats are used in your organization?
9. What languages and package formats do you anticipate adding in the future?
10. Which public repositories are accessed by your team?
11. Does your team plan to host components?
Mark only one oval.
 Yes
 No
12. Are multiple hosted repositories are needed?
Mark only one oval.
 Yes
 No
13. How many applications are managed in your
organization?
14. What gateway is used for external OSS and commercial components?
15. How much storage is needed for internal components and where will that storage be located?
16. How much storage is needed for build output and where will that storage be located?



[Content](#content)

## Creating and Managing Users


The repository manager comes with two users by default: admin and anonymous. The admin user has all privileges and the anonymous user has read-only privileges. The Anonymous role cannot be edited.

Best Practice
As a best practice, the first time Administrator logs in, they should create a new user and assign himself/herself with the Administrator role by completing the steps in the Creating Users section below. If you do not wish to do this, at the very least please be sure to change the default Admin password before beginning work in the repository manager. 


Viewing Privileges
Privileges are created dynamically as you add repository types and repositories to NXRM, as shown in the example screenshot below.  Privileges cannot be assigned directly to users. They must be added to a role. Then the role must be assigned to the users (or groups of users). An extensive list of privileges is already built in to the repository manager (as shown in the screenshot below). Administrators are able to view existing privileges and create custom privileges when needed.

Best Practice
Use the default privileges, and avoid creating new privileges whenever possible. This makes troubleshooting and managing privileges much easier. Following the concept of assigning the “least privilege” to accomplish the task will help to better manage access control in the long run.


Setting Repository Access
Privileges control access to specific functionality to any of the repositories that are installed or you have configured.

An extensive list of default privileges have been listed in the Nexus repository manager — and you can inspect those default privileges, and also create custom privileges to meet your needs, like grouping privileges in a role, and assign them to specific users.

These privileges not only allow you to read and update, they also provide accessibility to any part of the Nexus ecosystem — including access to the different areas within Nexus repository for the user interface, and the Admin Tools so you can leverage available actions such as BREAD (Browse, Read, Edit, Add, Delete) and CRUD (Create, Read, Update and Delete).


`Content Selectors `allow us to define what content can be accessed inside the repository. Think of it as virtual slices — of what you can see, what you can update — the whole read, update and administer concept, but use it as a context selector as a specific path inside the repository.

https://help.sonatype.com/repomanager3/nexus-repository-administration/access-control/content-selectors


Authenticated Credentials
How do users gets their credentials authenticated?

Out of the box, when you install Nexus repository manager, there’s a built in system where you can define users and they can set up their password.

However, a lot of large organizations, or any organization that already has LDAP or some way to authenticate its users, would rather not have to do that twice. If you want to utilize a single sign on and use the same credentials, you can do that.

And the way you can do that is by defining around Realms.

[Content](#content)



## Managing Maven Proxy and Hosted Repositories

### Maven Proxy Repository

`To link a remote repository where requests for components are verified against the cached components in your proxy repository.`

A proxy repository is a repository that is linked to a remote repository, such as the Central Repository. When using a proxy, requests for components are verified against the cached components in your proxy repository. When you search for components, if the request isn’t found in your proxy repository, it is forwarded to the Central Repository. That component is then retrieved from Central and cached in the repository manager. If you search for that same component again, it will be found in local storage. This eliminates the need to go to the Central Repository and reduces bandwidth and time needed to retrieve the components you need.

When components are stored in a caching proxy, a copy of those components stays indefinitely. In the event a component becomes unavailable in the Central Repository, you’ll still have access to it in your proxy. This provides more control over the components you need to build your applications.

Nexus Repository Manager ships out-of-the-box with a Maven-central proxy repository already configured to accesses the Central Repository. Even though there’s already a Maven Central proxy setup, for the purposes of this lesson, we’re going to make a new proxy repository, as described in the next section.


https://maven.apache.org/settings.html

#### Configure Maven for proxy

`~/.m2/settings.xml` https://maven.apache.org/settings.html

NOTE: If you haven’t `run mvn install`, the `~.m2` repo may not have been created. If you don’t see this repo, run `mkdir .m2 `and then add the `settings.xml `manually.

```xml
<settings>
  <mirrors>
    <mirror>
      <!--This sends everything else to /public -->
      <id>nexus</id>
      <mirrorOf>*</mirrorOf>
      <url>http://localhost:8081/repository/maven-proxy-test/</url>
    </mirror>
  </mirrors>
  <profiles>
    <profile>
      <id>nexus</id>
      <!--Enable snapshots for the built in central repo to direct -->
      <!--all requests to nexus via the mirror -->
      <repositories>
        <repository>
          <id>central</id>
          <url>http://central</url>
          <releases><enabled>true</enabled></releases>
          <snapshots><enabled>true</enabled></snapshots>
        </repository>
      </repositories>
     <pluginRepositories>
        <pluginRepository>
          <id>central</id>
          <url>http://central</url>
          <releases><enabled>true</enabled></releases>
          <snapshots><enabled>true</enabled></snapshots>
        </pluginRepository>
      </pluginRepositories>
    </profile>
  </profiles>
<activeProfiles>
    <!--make the profile active all the time -->
    <activeProfile>nexus</activeProfile>
  </activeProfiles>
  <servers>
    <server>
      <id>nexus</id>
      <username>admin</username>
      <password>your-password</password> 
    </server>
  </servers>
</settings>
```

##### Make a Maven Project

In this section, we’ll create a Maven project also known as a Project Object Model or POM. We’ll use this POM later to cache new components from Maven Central to your proxy repository.

From the command-line interface, make a new directory for your Maven project in the location of your choice. For example, navigate to your user directory and then use the command mkdir maven-test.
Open your new directory with cd maven-test.
Next, create a POM file (pom.xml) with the command touch pom.xml.
And open the file with open pom.xml
Populate your POM with the values below and save the file:

```xml

<project>
<modelVersion>4.0.0</modelVersion>
<groupId>com.example</groupId>
<artifactId>nexus-proxy</artifactId>
<version>1.0-SNAPSHOT</version>
<dependencies>
<dependency>
<groupId>junit</groupId>
<artifactId>junit</artifactId>
<version>4.10</version>
</dependency>
</dependencies>
</project>
```

##### Create a Maven Proxy Repository

Next up, we’ll create a new Maven proxy in the Nexus Repository Manager UI.

Open the Nexus Repository user interface.
Click Administration  in the top navigation menu.
Select Repositories.
Click Create repository.
Choose the maven2 (proxy) recipe from the list.
Add the following text in the required fields:
Name: maven-proxy-test
Remote storage URL: https://repo1.maven.org/maven2
Click Create repository to complete the form.
The repository manager is now configured to proxy Maven Central.

##### Cache New Components from Maven Central to the Proxy

The last step is to build our Maven project and then view the components in our proxy repository.

In your terminal, navigate to the POM file you created, and run the build with the command mvn package. Your build is ready when you see a BUILD SUCCESS message.
Click Browse  in the main toolbar.
Select Browse from the left-side menu.
Of your repositories, choose maven-proxy-test. You’ll see the test components you proxied for the Maven format during the previous steps.
Click on a component name to review its details.


### Maven Hosted Repositories

`To create a place for internal components that isn’t downloaded from a public repository, but is used by your development teams.`

n the previous section, you learned how to set up a proxy repository to Maven Central and use that to cache components from the public repo. This is hugely beneficial and saves time, but what do you do with internal components that aren’t downloaded from a public repository, but are used by various development teams in your organization? You make a hosted repository to act as the authoritative location for your in-house components.

Back in the first module, you learned that the default installation of Repository Manager includes two hosted Maven repositories. The maven-releases repository uses a release version policy, and the maven-snapshots repository uses a snapshot version policy.

Release repositories are intended to be the place where your organization publishes internal releases. A release component is a component created by a specific, versioned release. These components are considered to be solid, stable and perpetual to guarantee the builds that use them are repeatable over time. You can also use this repository for third-party components that are not available in external repositories and can’t be retrieved using a configured proxy repository.

Snapshot components change over time and are generated during active development of a software project. Continuous development is typically performed with snapshot versions supported by the Snapshot version policy. These version values have to end with -SNAPSHOT in the POM file. This allows repeated uploads where the actual number used is composed of a date/timestamp and an enumerator and the retrieval can still use the -SNAPSHOT version string.

Much like a production environment and a staging environment, we recommend using the release repository for stable components in production and a snapshot repository for components still in the development phase.


Configure a Hosted Repository
To use Maven hosted repositories, configure the POM to link your projects to maven-snapshots and maven-releases hosted repos. When these are done, you can go ahead and deploy your snapshot and release builds and then view the components in your hosted repositories.

Update the POM
Next, we need to configure deployment in our project. For both the snapshots and releases repositories, we’ll deploy to the out-of-the-box repos already in NXRM. Deployment to a repository is configured in the pom.xml for the respective project in the distributionManagement section.

Open your POM and add the following section between the <version> and <dependencies> tags:

```xml
<distributionManagement>
  <repository>
    <id>nexus</id>
    <name>maven-releases</name>
    <url>http://localhost:8081/repository/maven-releases/</url>
  </repository>
  <snapshotRepository>
    <id>nexus</id>
    <name>maven-snapshots</name>
    <url>http://localhost:8081/repository/maven-snapshots/</url>
  </snapshotRepository>
</distributionManagement>
```

The completed POM will look like this.

```xml
<project>
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.example</groupId>
  <artifactId>nexus-proxy</artifactId>
  <version>1.0-SNAPSHOT</version>


<distributionManagement>
  <repository>
  <id>nexus</id>
  <name>maven-releases</name>
  <url>http://localhost:8081/repository/maven-releases/</url>
 </repository>
 <snapshotRepository>
  <id>nexus</id>
  <name>maven-snapshots</name>
  <url>http://localhost:8081/repository/maven-snapshots/</url>
 </snapshotRepository>
</distributionManagement>

 <dependencies>
  <dependency>
    <groupId>junit</groupId>
    <artifactId>junit</artifactId>
    <version>4.10</version>
  </dependency>
  </dependencies>
</project>
```

Run Snapshots Build
In your terminal, navigate to your POM, and run the build with mvn clean deploy. Your build is ready when you see a BUILD SUCCESS message.
In Nexus Repository Manager, click Browse  in the main toolbar and then select Browse from the left-side menu.
Of your repositories, choose maven-snapshots. You’ll see the test components from your Maven Snapshots build.
Click on a component name to review its details.

Run Release Build
When ready for release, remove SNAPSHOT from the version tag in your pom: <version>1.0-SNAPSHOT</version>
Save your POM.
In your terminal, navigate to your POM, and run the build with mvn clean deploy. Your build is ready when you see a BUILD SUCCESS message.
In Nexus Repository Manager, click Browse  in the main toolbar and then select Browse from the left-side menu.
Of your repositories, choose maven-releases. You’ll see the test components from your Maven Releases build.
Click on a component name to review its details.


## Managing Repository Groups

A repository group is:

Its own access point, separate from proxy and hosted repositories.
Created by adding repositories as members of a ordered list.
A combined repository of locally published and remotely cached components.
A unique endpoint that users can access without having to retrieve components from hosted and proxy repositories.
A repository group is a one-stop location where developers can collaborate on a project with all available components assigned to it. If you’re an administrator, you can dynamically add repositories without updating developer settings. If you’re a developer, you can access the contents of the group by sending requests directly to the repository manager.

The request passes through a list of combined repositories, looking for a component. The first match in the group ordering is what will be returned to a developer’s local environment. These requests can be done by running a software build from your terminal.

Repository groups become necessary if your organization has multiple teams working on multiple projects. If you’re an administrator you’ll find it less cumbersome to order your proxy and hosted repositories into a group designed for a development team.

It’s important to note that a group doesn’t store components. You can’t publish or deploy components directly to this repository type. Groups just aggregate content from other repositories. If you want to modify components in a group repository, publish those changes to a hosted repository included in the group.

#### An Example

Let’s say you create a new proxy repository to cache an open source component from a remote server. Now, enter a team assigned to develop a new feature. All work in this feature would be published and stored in a hosted repository. Next, the administrator will create a repository group, combining the cached component from the remote repository and the feature developed locally by the team.

Instead of making requests to the proxy repository or to the hosted for the feature, all components become retrievable in this new location: the group repository. The development team will only need to access the components from this newly created group repository.

#### Understanding Maven Group Repositories

When you install Nexus Repository, look for one specific built-in repository called maven-public. If you recall in Repository Manager Basics, this pre-configured group consists of:

The remote proxy for the Central Repository
Maven-snapshots, a repository for you to host multiple versions of a project in development
Maven-releases, a repository for you to host a stable project set for production
In a standard software development life cycle (SDLC) developers are given access to the public Maven group. This group becomes the endpoint to retrieve and build a current project. Now, inside the group there will be at least one hosted repository. This is where developers publish new projects or iterations of existing projects. If developing snapshots, your developers will continually publish their work to maven-snapshots, a hosted location. On the other hand, maven-releases offers a location to host a project that is deemed worthy for software deployment. In both cases, this project will be updated to the hosted location, then added to the group.

### Create a Repository Group: Maven-all

Select Repositories.
Then Create repository.
Choose the maven2 (group) recipe.
Fill out the form, using maven-all as the Name.
Drag and drop the Available proxy and hosted repositories you created in the previous lesson to the Member field. Alternatively, you can double click an individual Available repository making it appear in the Members field.
Click Save to complete the form.
Make a note of the the group URL from the Repositories screen. The repository URL for this example is: http://localhost:8081/repository/maven-all.
When adding members to your group, we recommend you order your hosted repositories at the top, above your proxies. In common snapshot scenarios, your team will develop internal, hosted components then upload each improvement to the repository manager. Each time a request for a version is made, its retrieval is faster if organized in sequential order.


#### Customize your Settings for Group Access


In most scenarios, developers can’t access Maven Central. Instead of downloading from the remote location, it’s a better practice to download from the group in Nexus Repository. In order to do this, modify the mirror configuration in your settings.xml to point to your group. This minor adjustment overrides the default configuration values and provides an access point that your developers can use to build their projects.


To do this:

Copy the group URL from the Repositories screen.
Locate and open your settings.xml file: open ~/.m2/settings.xml
Paste the URL for maven-all into the mirror config section similar to the sample settings file: http://localhost:8081/repository/maven-all/
Save and close the file.

 `mvn install`


 [Content](#content)



 Lab 1 install maven


 install gradle

 docker

 ----

 Lab2 proxy

 Nexus Repository Manager ships out-of-the-box with a Maven-central proxy repository already configured to accesses the Central Repository. 


 Configure Maven
In the following exercise, we’ll show you how to configure Maven to check your Nexus Repository Manager, make a test project, and then create and populate a Maven proxy repository.

To use the repository manager with Apache Maven, you need to first configure Maven to check the repository manager instead of the default, built-in connection to the Central Repository. To do this, add a mirror configuration and override the default configuration for the central repository in your ~/.m2/settings.xml as shown below.  The file will include the server credentials you set up in the installation section. More information on Maven settings.

NOTE: If you haven’t run mvn install, the ~.m2 repo may not have been created. If you don’t see this repo, run mkdir .m2 and then add the settings.xml manually.

<settings>
  <mirrors>
    <mirror>
      <!--This sends everything else to /public -->
      <id>nexus</id>
      <mirrorOf>*</mirrorOf>
      <url>http://localhost:8081/repository/maven-proxy-test/</url>
    </mirror>
  </mirrors>
  <profiles>
    <profile>
      <id>nexus</id>
      <!--Enable snapshots for the built in central repo to direct -->
      <!--all requests to nexus via the mirror -->
      <repositories>
        <repository>
          <id>central</id>
          <url>http://central</url>
          <releases><enabled>true</enabled></releases>
          <snapshots><enabled>true</enabled></snapshots>
        </repository>
      </repositories>
     <pluginRepositories>
        <pluginRepository>
          <id>central</id>
          <url>http://central</url>
          <releases><enabled>true</enabled></releases>
          <snapshots><enabled>true</enabled></snapshots>
        </pluginRepository>
      </pluginRepositories>
    </profile>
  </profiles>
<activeProfiles>
    <!--make the profile active all the time -->
    <activeProfile>nexus</activeProfile>
  </activeProfiles>
  <servers>
    <server>
      <id>nexus</id>
      <username>admin</username>
      <password>your-password</password> 
    </server>
  </servers>
</settings>
Make a Maven Project
In this section, we’ll create a Maven project also known as a Project Object Model or POM. We’ll use this POM later to cache new components from Maven Central to your proxy repository.

From the command-line interface, make a new directory for your Maven project in the location of your choice. For example, navigate to your user directory and then use the command mkdir maven-test.
Open your new directory with cd maven-test.
Next, create a POM file (pom.xml) with the command touch pom.xml.
And open the file with open pom.xml
Populate your POM with the values below and save the file:
<project>
<modelVersion>4.0.0</modelVersion>
<groupId>com.example</groupId>
<artifactId>nexus-proxy</artifactId>
<version>1.0-SNAPSHOT</version>
<dependencies>
<dependency>
<groupId>junit</groupId>
<artifactId>junit</artifactId>
<version>4.10</version>
</dependency>
</dependencies>
</project>
Create a Maven Proxy Repository
Next up, we’ll create a new Maven proxy in the Nexus Repository Manager UI.

Open the Nexus Repository user interface.
Click Administration  in the top navigation menu.
Select Repositories.
Click Create repository.
Choose the maven2 (proxy) recipe from the list.
Add the following text in the required fields:
Name: maven-proxy-test
Remote storage URL: https://repo1.maven.org/maven2
Click Create repository to complete the form.
The repository manager is now configured to proxy Maven Central.

Cache New Components from Maven Central to the Proxy
The last step is to build our Maven project and then view the components in our proxy repository.

In your terminal, navigate to the POM file you created, and run the build with the command mvn package. Your build is ready when you see a BUILD SUCCESS message.
Click Browse  in the main toolbar.
Select Browse from the left-side menu.
Of your repositories, choose maven-proxy-test. You’ll see the test components you proxied for the Maven format during the previous steps.
Click on a component name to review its details.



lab 3 hosted


Configure a Hosted Repository
To use Maven hosted repositories, configure the POM to link your projects to maven-snapshots and maven-releases hosted repos. When these are done, you can go ahead and deploy your snapshot and release builds and then view the components in your hosted repositories.

Update the POM
Next, we need to configure deployment in our project. For both the snapshots and releases repositories, we’ll deploy to the out-of-the-box repos already in NXRM. Deployment to a repository is configured in the pom.xml for the respective project in the distributionManagement section.

Open your POM and add the following section between the <version> and <dependencies> tags:

<distributionManagement>
  <repository>
    <id>nexus</id>
    <name>maven-releases</name>
    <url>http://localhost:8081/repository/maven-releases/</url>
  </repository>
  <snapshotRepository>
    <id>nexus</id>
    <name>maven-snapshots</name>
    <url>http://localhost:8081/repository/maven-snapshots/</url>
  </snapshotRepository>
</distributionManagement>
The completed POM will look like this.

<project>
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.example</groupId>
  <artifactId>nexus-proxy</artifactId>
  <version>1.0-SNAPSHOT</version>


<distributionManagement>
  <repository>
  <id>nexus</id>
  <name>maven-releases</name>
  <url>http://localhost:8081/repository/maven-releases/</url>
 </repository>
 <snapshotRepository>
  <id>nexus</id>
  <name>maven-snapshots</name>
  <url>http://localhost:8081/repository/maven-snapshots/</url>
 </snapshotRepository>
</distributionManagement>

 <dependencies>
  <dependency>
    <groupId>junit</groupId>
    <artifactId>junit</artifactId>
    <version>4.10</version>
  </dependency>
  </dependencies>
</project>
Then, save the updated POM. Setup is now complete, so next you’ll run the builds and view our hosted components in the Nexus Repository Manager UI.

Run Snapshots Build
In your terminal, navigate to your POM, and run the build with mvn clean deploy. Your build is ready when you see a BUILD SUCCESS message.
In Nexus Repository Manager, click Browse  in the main toolbar and then select Browse from the left-side menu.
Of your repositories, choose maven-snapshots. You’ll see the test components from your Maven Snapshots build.
Click on a component name to review its details.
Run Release Build
When ready for release, remove SNAPSHOT from the version tag in your pom: <version>1.0-SNAPSHOT</version>
Save your POM.
In your terminal, navigate to your POM, and run the build with mvn clean deploy. Your build is ready when you see a BUILD SUCCESS message.
In Nexus Repository Manager, click Browse  in the main toolbar and then select Browse from the left-side menu.
Of your repositories, choose maven-releases. You’ll see the test components from your Maven Releases build.
Click on a component name to review its details.
Exercise Summary
So…what did we just do? We mapped maven-releases and maven-snapshots to our project by adding a Distribution Management section to the POM.

Then, we ran a snapshots build with mvn clean deploy and verified the snapshots hosted repo was populated in the UI.

Finally, we removed the snapshots tag from our POM and then ran mvn clean deploy again to get the release repo.




Lab group repo



Configuring Groups for Maven Repositories
In lesson two you already became familiar with basic terms for Maven and stood up proxy and hosted repositories. In the following exercise you’ll:

Create a repository group from the UI.
Configure the settings file in the backend, pointing to the repository group.
Run your Maven build to download components to the group.
Access the UI to inspect components using tree view and also find merged components.


Create a Repository Group: Maven-all
In the same way you created other repositories, go to the Repositories screen and do the following:

Select Repositories.
Then Create repository.
Choose the maven2 (group) recipe.
Fill out the form, using maven-all as the Name.
Drag and drop the Available proxy and hosted repositories you created in the previous lesson to the Member field. Alternatively, you can double click an individual Available repository making it appear in the Members field.
Click Save to complete the form.
Make a note of the the group URL from the Repositories screen. The repository URL for this example is: http://localhost:8081/repository/maven-all.
When adding members to your group, we recommend you order your hosted repositories at the top, above your proxies. In common snapshot scenarios, your team will develop internal, hosted components then upload each improvement to the repository manager. Each time a request for a version is made, its retrieval is faster if organized in sequential order.

Customize your Settings for Group Access
Now that you’ve created the group from the UI, you need to modify your settings.xml file to a location where users can access the group’s content.

The default configuration for Nexus Repository relies on a “Super POM.” The Super POM is a global file in Maven that connects to the Central Repository. It’s internal to every Maven install and establishes default configurations values. It comes built-in your newly installed repository manager.

In most scenarios, developers can’t access Maven Central. Instead of downloading from the remote location, it’s a better practice to download from the group in Nexus Repository. In order to do this, modify the mirror configuration in your settings.xml to point to your group. This minor adjustment overrides the default configuration values and provides an access point that your developers can use to build their projects.

NOTE: If you completed lesson two, you’ll have a Maven settings file with a mirror configured to a proxy repository URL that looks like this: http://localhost:8081/repository/maven-proxy-test/. In the next step, you’ll edit that URL to point to the group.

To do this:

Copy the group URL from the Repositories screen.
Locate and open your settings.xml file: open ~/.m2/settings.xml
Paste the URL for maven-all into the mirror config section similar to the sample settings file: http://localhost:8081/repository/maven-all/
Save and close the file.
Run your Maven Build
Locate your maven-test project in your terminal:

Change the directory location to maven-test: cd maven-test.
Run mvn install from this location. The build may take a few seconds, but you’ll see BUILD SUCCESS upon completion.
The BUILD SUCCESS message indicates the components are downloaded from the group where your developers can access its contents.

From this point on, if your developers need another repository, create it and add it to the repository group that consolidates everything into a single point of access.

Now that you successfully downloaded components from the group, locate the merged components from the project you built in the repository group UI.

Locate Components in the Repository Group
Nexus Repository Manager has a browse feature allowing you to inspect the contents of a repository group. From the Browse  screen, navigate to your component and drill down for details with the tree view feature.

Tree view is a graphical element that presents an indented, hierarchical view of components and the assets that make up components. Each item – or node – has a number of sub-items, nested by the structure of Maven’s naming conventions. Nodes in the tree are sorted in case-insensitive order. Versions are sorted semantically.

Access the User Interface to Find Merged Components
To locate all grouped components go to the Browse screen. Then, select the repository group by doing the following:

Click Browse from the Administration menu.
Select maven-all, your group repository; this takes you to the Browse screen.
Click on the parent folder of a specific component; the row expands downward in tree view containing all assets of the component.
Locate and click the node label with the file version (e.g. 1.0.1); this reveals a nested list of assets.
When you click this node, the folder will reveal the contents of your proxy and hosted repositories combined; both are children in the same parent folder. The package icon (denoting component version) shows a list of assets that make up the components, such as JAR, POM, and hash files.

Clicking on assets allows you to see a summary screen and a list of attributes on the right panel. The Summary section lists a number of attributes about the specific asset. The Attributes section contains further metadata about the asset related to Cache, Checksum, Content, and Maven attributes.

