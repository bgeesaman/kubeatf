# KubeATF

## Description
The Kubernetes *A*nsible *T*esting *F*ramework is a tool meant to spin up, test, save results, and spin down Kubernetes clusters using the various installation tools/kits/templates readily available in a human and CI/CD friendly way.

In order to reduce conflicts of tools/versions as well as negate the need for having to install specific tools onto your system, ```KubeATF``` builds all the tools needed into a Docker container.  This is to allow for easy customization by you, the end user, to bake in whatever tools and scripts you may want to inject and make easy to deploy inside a CI/CD system that can run docker containers as build steps.

## Use Cases
1. **Kubernetes Installation Tool Testing** - If you are a maintainer of a Kubernetes installation tool, this provides a mechanism to create a repeatable process for creating test clusters to improve consistency and reduce time spent during development.

2. **Kubernetes Release Testing** - If you are running the e2e (end to end) testing suite on various releases/configurations, this tool may help you.

3. **Kubernetes Application Testing** - If you are deploying an application or a helm chart inside Kubernetes and you are concerned with ensuring compatibility across clouds and versions of Kubernetes, this tool may help you.

4. **Kubernetes Security Testing** - If you are assessing multiple installation tools for their security posture using things like CIS Benchmarking checks, this tool can help automate the testing process.


## Getting Started

These instructions will get you a copy of the project up and running on your local machine.

#### Prerequisites

In order to run this tool, you will need the following installed on your Linux/OSX system (which you probably already have):

* ```bash 3.x``` or newer
* ```git 2.x``` or newer
* ```docker 1.12``` or newer

#### Downloading KubeATF

1. In order to install the tool, simply clone this repository:

  ```sh
  $ git clone https://github.com/bgeesaman/kubeatf
  $ cd kubeatf
  ```

2. Ensure you have your SSH key (<name>.pem) in ```~/.ssh/```

  ```sh
  $ ls ~/.ssh/kube.pem
  kube.pem
  ```

3. Ensure you have your AWS credentials in ```~/.aws```

  ```sh
  $ ls ~/.aws/
  config      credentials
  ```

4. Build the docker image locally:

  ```sh
  $ ./kubeatf docker build
  ```

#### Listing available releases

```sh
$ ./kubeatf get releases <toolname>
```

e.g.

```sh
$ ./kubeatf get releases kops
```
  
#### Obtaining a release

```sh
$ ./kubeatf get <toolname> <release>
```
e.g. 

```sh
$ ./kubeatf get kops 1.7.0
```

#### Configuring an Environment

1. ```TODO```
2. sa

#### Running a test

1. ```TODO```
2. sa

#### Viewing the results

1. ```TODO```
2. sa

#### Troubleshooting

Run ```./kubeatf``` for basic usage or ```./kubeatf help <command>``` to access detailed usage instructions.

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/bgeesaman/kubeatf/tags). 

## Contributors

* **Brad Geesaman** - Author - [bgeesaman](https://github.com/bgeesaman)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Docker
* Ansible
* Kubernetes and the Kubernetes Community
